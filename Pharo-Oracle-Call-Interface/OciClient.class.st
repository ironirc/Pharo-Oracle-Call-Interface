"
I am OciClient, an Oracle Call Interface client for Pharo.

I use an FFI binding to the OCI client library.

```
| client rows |

client := OciClient new
	environmentString: 'pharotst202112_medium';
	username: 'SCOTT';
	password: 'TIGER';
	yourself.
rows := client query: 'SELECT * FROM emp'.		
client close.
rows.
```

"
Class {
	#name : #OciClient,
	#superclass : #Object,
	#instVars : [
		'environmentHandle',
		'serviceContextHandle',
		'password',
		'username',
		'environmentString',
		'encoding',
		'oracleEncodingId',
		'oracleUnicodeEncodingId',
		'authenticationMode',
		'executionMode',
		'errorHandle',
		'parameterPointer',
		'sessionHandle',
		'serverHandle',
		'transactionHandle',
		'isMaxStringSizeExtended'
	],
	#classVars : [
		'ociTypeToSmalltalkTypeMapping'
	],
	#pools : [
		'OciConstants',
		'OciConstantsExternalDataTypes',
		'OciConstantsInternalDataTypes'
	],
	#category : #'Pharo-Oracle-Call-Interface-Core'
}

{ #category : #accessing }
OciClient class >> encodingMapping [
	^ Dictionary new
		add: 'UTF8' -> #utf_8;
		add: 'AL32UTF8' -> #utf_8;
		add: 'UTF16' -> #utf_16;
		yourself
]

{ #category : #public }
OciClient class >> getEncodingFromNlsLangEnvironmentVariable [
"
self getEncodingFromNlsLangEnvironmentVariable
"
	| envString envStringFragment |
	envString := OSEnvironment current at: 'NLS_LANG' ifAbsent: [ '' ].
	envStringFragment := envString
		copyFrom: (envString indexOf: $.) + 1
		to: envString size.
	(envStringFragment isEmpty or: [ envStringFragment = 'NA' ])
		ifTrue: [ ^ #default ].
	^ self encodingMapping
		at: envStringFragment
		ifAbsent: [ self error: 'Unknown column encoding' ]
]

{ #category : #accessing }
OciClient class >> ociTypeToSmalltalkTypeMapping [
	ociTypeToSmalltalkTypeMapping
		ifNil: [ ociTypeToSmalltalkTypeMapping := IdentityDictionary new
				add: SQLT_CHR -> #String;
				add: SQLT_NUM -> #Number;
				add: SQLT_LNG -> #String;
				add: SQLT_RID -> #String;
				add: SQLT_DAT -> #DateAndTime;
				add: SQLT_BIN -> #ByteArray;
				add: SQLT_LBI -> #ByteArray;
				add: SQLT_AFC -> #String;
				add: SQLT_RDD -> #String;
				add: SQLT_LAB -> #String;
				add: SQLT_CLOB -> #String;
				add: SQLT_BLOB -> #ByteArray;
				add: SQLT_TIMESTAMP -> #DateAndTime;
				yourself ].
	^ociTypeToSmalltalkTypeMapping
]

{ #category : #accessing }
OciClient >> authenticationMode [
	^ authenticationMode
]

{ #category : #accessing }
OciClient >> authenticationMode: anObject [
	authenticationMode := anObject
]

{ #category : #accessing }
OciClient >> bufferSizeForLongType [
	self flag: 'refine'.
	^ 32000
]

{ #category : #'initialize-release' }
OciClient >> close [
	self isConnected ifFalse: [ ^ self ].
	self ociSessionEnd.
	self ociServerDetach.
	self ociFreeAllHandles.
]

{ #category : #'initialize-release' }
OciClient >> connect [
	self isConnected ifTrue: [ ^ self ].
	self initializeOciHandlesAndStuff
]

{ #category : #'accessing derived' }
OciClient >> encoding [
	encoding
		ifNil: [ encoding := self class getEncodingFromNlsLangEnvironmentVariable
				ifNil: [ self getEncodingFromOci ] ].
	^ encoding
]

{ #category : #private }
OciClient >> ensureConnected [

	self isConnected ifFalse: [ self connect ]
]

{ #category : #accessing }
OciClient >> environmentHandle [
	^ environmentHandle
]

{ #category : #accessing }
OciClient >> environmentHandle: aHandle [
	environmentHandle := aHandle
]

{ #category : #accessing }
OciClient >> environmentString [
	^ environmentString
]

{ #category : #accessing }
OciClient >> environmentString: anObject [
	environmentString := anObject
]

{ #category : #accessing }
OciClient >> errorHandle [
	^ errorHandle
]

{ #category : #accessing }
OciClient >> errorHandle: externalAddress [
	 errorHandle := externalAddress
]

{ #category : #public }
OciClient >> execute: sqlStatementString [
	"Execute sqlStatementString as an alias to query where the result is not needed"
	
	self query: sqlStatementString
]

{ #category : #private }
OciClient >> getEncodingFromOci [

	self flag: 'to be implemented'.
	^self halt
]

{ #category : #'error handling' }
OciClient >> getErrors [
	^ self errorHandle
		ifNil: [ self error: 'unable to get errors because error handle is not initialized' ]
		ifNotNil: [ self ociGetErrors ]
]

{ #category : #'private oci calls' }
OciClient >> handleErrorsWithReturnValue: rv [

	self getErrors ifNotNil: [ :errs | 
		errs isEmpty ifFalse: [ 
			self raiseErrorForErrors: errs returnValue: rv ] ]
]

{ #category : #'initialize-release' }
OciClient >> initialize [
	super initialize.
	parameterPointer := ExternalAddress new.
	self oracleEncodingId: 0.	"871"
	self oracleUnicodeEncodingId: 0.	"871"
	self isMaxStringSizeExtended: false.	"https://docs.oracle.com/database/121/REFRN/GUID-D424D23B-0933-425F-BC69-9C0E6724693C.htm#REFRN10321"
	self useCredentialsUsernamePassword.
]

{ #category : #private }
OciClient >> initializeOciHandlesAndStuff [
	self environmentHandle: self ociEnvNlsCreate.
	self ociServerAttach.
	self
		ociAttributeSetHandle: self serverHandle
		type: OCI_ATTR_SERVER
		descriptor: self serviceContextHandle
		type: OCI_HTYPE_SVCCTX.
	self authenticationMode == OCI_CRED_RDBMS
		ifTrue: [ self username ifNil: [ self error: 'username missing' ].
			self password ifNil: [ self error: 'password missing' ].
			self
				ociAttributeSetString: self username
				type: OCI_ATTR_USERNAME
				descriptor: self sessionHandle
				type: OCI_HTYPE_SESSION.
			self
				ociAttributeSetString: self password
				type: OCI_ATTR_PASSWORD
				descriptor: self sessionHandle
				type: OCI_HTYPE_SESSION ].
	self
		ociAttributeSetHandle: self transactionHandle
		type: OCI_ATTR_TRANS
		descriptor: self serviceContextHandle
		type: OCI_HTYPE_SVCCTX.
	self
		ociAttributeSetHandle: self sessionHandle
		type: OCI_ATTR_SESSION
		descriptor: self serviceContextHandle
		type: OCI_HTYPE_SVCCTX.
	self ociSessionBegin
]

{ #category : #testing }
OciClient >> isConnected [
	^ self sessionHandle notNil and: [ self sessionHandle isNull not ]
]

{ #category : #accessing }
OciClient >> isMaxStringSizeExtended [
	^ isMaxStringSizeExtended
]

{ #category : #accessing }
OciClient >> isMaxStringSizeExtended: anObject [
	isMaxStringSizeExtended := anObject
]

{ #category : #'accessing derived' }
OciClient >> maxVarcharStringSize [
	"https://docs.oracle.com/database/121/REFRN/GUID-D424D23B-0933-425F-BC69-9C0E6724693C.htm#REFRN10321"
	^ self isMaxStringSizeExtended
		ifFalse: [ 4000 ]
		ifTrue: [ 32767 ]
]

{ #category : #'private oci calls' }
OciClient >> ociAllocateAllHandles [
	self ociAllocateErrorHandle.
	self ociAllocateServiceContextHandle.
	self ociAllocateServerHandle.
	self ociAllocateSessionHandle.
	self ociAllocateTransactionHandle
]

{ #category : #'private oci calls' }
OciClient >> ociAllocateErrorHandle [
	self errorHandle: (self ociAllocateHandleOfType: OCI_HTYPE_ERROR)
]

{ #category : #'private oci calls' }
OciClient >> ociAllocateHandleOfType: handleType [
	| newHandle returnValue |
	newHandle := ExternalAddress new.
	returnValue := Oci
		OCIHandleAlloc: self environmentHandle
		hndlpp: newHandle
		type: handleType
		xtramem_sz: 0
		usrmempp: nil.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ newHandle ].
	self signalErrorWith: [ :ws | ws << 'OCIHandleAlloc for type: ' << handleType << ' failed. (errCode: ' << returnValue << ')' ]
]

{ #category : #'private oci calls' }
OciClient >> ociAllocateServerHandle [
	self serverHandle: (self ociAllocateHandleOfType: OCI_HTYPE_SERVER)
]

{ #category : #'private oci calls' }
OciClient >> ociAllocateServiceContextHandle [
	self serviceContextHandle: (self ociAllocateHandleOfType: OCI_HTYPE_SVCCTX)
]

{ #category : #'private oci calls' }
OciClient >> ociAllocateSessionHandle [
	self sessionHandle: (self ociAllocateHandleOfType: OCI_HTYPE_SESSION)
]

{ #category : #'private oci calls' }
OciClient >> ociAllocateTransactionHandle [
	self transactionHandle: (self ociAllocateHandleOfType: OCI_HTYPE_TRANS)
]

{ #category : #'private oci calls' }
OciClient >> ociAttributeGet: attributeType length: sizep descriptor: descriptor type: descriptorType [
	| returnValue attributep |
	attributep := ByteArray new: (ExternalAddress wordSize).
	returnValue := Oci
		OCIAttrGet: descriptor
		trghndltyp: descriptorType
		attributep: attributep
		sizep: sizep
		attrtype: attributeType
		errhp: self errorHandle.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ attributep ].
	self handleErrorsWithReturnValue: returnValue
]

{ #category : #'private oci calls' }
OciClient >> ociAttributeGetBoolean: attributeType descriptor: descriptor type: descriptorType [
	^ (self ociAttributeGetInteger: attributeType descriptor: descriptor type: descriptorType) == 1
]

{ #category : #'private oci calls' }
OciClient >> ociAttributeGetInteger: attributeType descriptor: descriptor type: descriptorType [
	| attributeBuffer |
	attributeBuffer := self
		ociAttributeGet: attributeType
		length: nil
		descriptor: descriptor
		type: descriptorType.
	^ attributeBuffer unsignedShortAt: 1
]

{ #category : #'private oci calls' }
OciClient >> ociAttributeGetString: attributeType descriptor: descriptor type: descriptorType [
	| attributeBuffer |
	attributeBuffer := self
		ociAttributeGet: attributeType
		length: nil
		descriptor: descriptor
		type: descriptorType.
	^ attributeBuffer asExternalPointer readStringUTF8
]

{ #category : #'private oci calls' }
OciClient >> ociAttributeSet: attributePointer size: size type: anAttributeType descriptor: aDescriptor type: aDescriptorType [
	| returnValue |
	returnValue := Oci
		OCIAttrSet: aDescriptor
		trghndltyp: aDescriptorType
		attributep: attributePointer
		size: size
		attrtype: anAttributeType
		errhp: self errorHandle.
	returnValue == OCI_SUCCESS
		ifFalse: [ self handleErrorsWithReturnValue: returnValue ]
]

{ #category : #'private oci calls' }
OciClient >> ociAttributeSetHandle: aHandle type: attributeType descriptor: descriptor type: descriptorType [
	self
		ociAttributeSet: aHandle
		size: 0
		type: attributeType
		descriptor: descriptor
		type: descriptorType
]

{ #category : #'private oci calls' }
OciClient >> ociAttributeSetInteger: anInteger type: anAttributeType descriptor: aDescriptor type: aDescriptorType [
	self
		ociAttributeSet: (ByteArray with: anInteger)
		size: 1
		type: anAttributeType
		descriptor: aDescriptor
		type: aDescriptorType
]

{ #category : #'private oci calls' }
OciClient >> ociAttributeSetString: aString type: anAttributeType descriptor: aDescriptor type: aDescriptorType [
	| encodedString |
	encodedString := aString encodeWith: #utf8.
	self
		ociAttributeSet: encodedString
		size: encodedString size
		type: anAttributeType
		descriptor: aDescriptor
		type: aDescriptorType
]

{ #category : #'private oci calls' }
OciClient >> ociEnvNlsCreate [
	| externalAddr returnValue |
	externalAddr := ExternalAddress new.
	returnValue := Oci
		OCIEnvNlsCreate: externalAddr
		mode: OCI_DEFAULT
		ctxp: nil
		malocfp: 0
		ralocfp: 0
		mfreefp: 0
		xtramemsz: 0
		usrmempp: ExternalAddress null
		charset: self oracleEncodingId
		ncharset: self oracleUnicodeEncodingId.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ externalAddr ].
	self signalErrorWith: [ :ws | ws << 'OCIEnvNlsCreate failed. (errCode: ' << returnValue << ')' ]
]

{ #category : #'private oci calls' }
OciClient >> ociErrorGet: handleOrNil type: errorType at: errorIndex [
	| buffer rtval bufferErrorCode |
	buffer := ByteArray new: 512.
	bufferErrorCode := ByteArray new: 4.
	rtval := Oci
		OCIErrorGet: handleOrNil
		recordno: errorIndex
		sqlstate: #dummyValue
		errcodep: bufferErrorCode
		bufp: buffer
		bufsiz: buffer size
		type: errorType.
	rtval == OCI_NO_DATA ifTrue: [ ^nil ].
	rtval == OCI_SUCCESS
		ifTrue: [ ^ OciErrorDescription new
				code: (bufferErrorCode unsignedShortAt: 1);
				description: (String streamContents: [ :ws | ws << (buffer utf8Decoded readStream upTo: Character lf) ]);
				yourself ].
	Error signal: 'failed to retrieve oci error code and description'
]

{ #category : #'private oci calls' }
OciClient >> ociFreeAllHandles [
	self ociFreeTransactionHandle.
	self ociFreeSessionHandle.
	self ociFreeServerHandle.
	self ociFreeServiceContextHandle.
	self ociFreeErrorHandle
]

{ #category : #'private oci calls' }
OciClient >> ociFreeErrorHandle [
	self ociFreeHandle: self errorHandle type: OCI_HTYPE_ERROR
]

{ #category : #'private oci calls' }
OciClient >> ociFreeHandle: aHandle type: aType [
	aHandle ifNil: [ ^self ].
	aHandle isNull ifTrue: [ ^self ].
	Oci OCIHandleFree: aHandle type: aType.
	aHandle beNull
]

{ #category : #'private oci calls' }
OciClient >> ociFreeServerHandle [
	self ociFreeHandle: self serverHandle type: OCI_HTYPE_SERVER
]

{ #category : #'private oci calls' }
OciClient >> ociFreeServiceContextHandle [
	self ociFreeHandle: self serviceContextHandle type: OCI_HTYPE_SVCCTX
]

{ #category : #'private oci calls' }
OciClient >> ociFreeSessionHandle [
	self ociFreeHandle: self sessionHandle type: OCI_HTYPE_SESSION
]

{ #category : #'private oci calls' }
OciClient >> ociFreeTransactionHandle [
	self ociFreeHandle: self transactionHandle type: OCI_HTYPE_TRANS
]

{ #category : #'private oci calls' }
OciClient >> ociGetErrors [

	^ OrderedCollection streamContents: [ :ws | 
		  | err errorIndex |
		  errorIndex := 1.
		  [ 
		  err := self
			         ociErrorGet: self errorHandle
			         type: OCI_HTYPE_ERROR
			         at: errorIndex.
		  err isNil ] whileFalse: [ 
			  ws << err.
			  errorIndex := errorIndex + 1 ] ]
]

{ #category : #'private oci calls' }
OciClient >> ociParamGet: hDescriptor type: descriptorType startingAt: position [
	| returnValue externalAddress |
	externalAddress := ExternalAddress new.
	returnValue := Oci
		OCIParamGet: hDescriptor
		htype: descriptorType
		errhp: self errorHandle
		parmdpp: externalAddress
		pos: position.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ externalAddress "always release the descriptor with OCIDescriptorFree (type OCI_DTYPE_PARAM)" ].
	returnValue == OCI_ERROR
		ifTrue: [ ^ nil ]
]

{ #category : #'private oci calls' }
OciClient >> ociServerAttach [
	| env returnValue |
	self ociAllocateAllHandles.
	self environmentString ifNil: [ self error: 'environmentString missing' ].
	env := self environmentString ifNotNil: [ :envString | envString nullTerminatedEncodeWith: #utf8].
	returnValue := Oci
		OCIServerAttach: self serverHandle
		errhp: self errorHandle
		dblink: env
		dblink_len: (env ifNotNil: [env size])
		mode: OCI_DEFAULT.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ self ].
	self handleErrorsWithReturnValue: returnValue
]

{ #category : #'private oci calls' }
OciClient >> ociServerDetach [
	| returnValue |
	returnValue := Oci OCIServerDetach: self serverHandle errhp: self errorHandle mode: OCI_DEFAULT.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ self ].
	self handleErrorsWithReturnValue: returnValue.
	
]

{ #category : #'private oci calls' }
OciClient >> ociSessionBegin [
	| returnValue |
	returnValue := Oci
		OCISessionBegin: self serviceContextHandle
		errhp: self errorHandle
		usrhp: self sessionHandle
		credt: authenticationMode
		mode: OCI_STMT_CACHE.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ self ].
	self handleErrorsWithReturnValue: returnValue
]

{ #category : #'private oci calls' }
OciClient >> ociSessionEnd [
	| returnValue |
	returnValue := Oci
		OCISessionEnd: self serviceContextHandle
		errhp: self errorHandle
		usrhp: self sessionHandle
		mode: OCI_DEFAULT.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ self ].
	self handleErrorsWithReturnValue: returnValue
]

{ #category : #'private oci calls' }
OciClient >> ociTransactionCommit [

	| returnValue |
	returnValue := Oci
		               OCITransCommit: self serviceContextHandle
		               errhp: self errorHandle
		               flags: OCI_DEFAULT.
	returnValue == OCI_SUCCESS ifTrue: [ ^ self ].
	self handleErrorsWithReturnValue: returnValue
]

{ #category : #'private oci calls' }
OciClient >> ociTransactionRollback [

	| returnValue |
	returnValue := Oci
		               OCITransRollback: self serviceContextHandle
		               errhp: self errorHandle
		               flags: OCI_DEFAULT.
	returnValue == OCI_SUCCESS ifTrue: [ ^ self ].
	self handleErrorsWithReturnValue: returnValue
]

{ #category : #'private oci calls' }
OciClient >> ociTransactionStart [
	| returnValue |
	returnValue := Oci
		OCITransStart: self serviceContextHandle errhp: self errorHandle timeout: 1 flags: OCI_TRANS_NEW.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ self ].
	self handleErrorsWithReturnValue: returnValue
]

{ #category : #accessing }
OciClient >> oracleEncodingId [
	^ oracleEncodingId
]

{ #category : #accessing }
OciClient >> oracleEncodingId: anObject [
	oracleEncodingId := anObject
]

{ #category : #accessing }
OciClient >> oracleUnicodeEncodingId [
	^ oracleUnicodeEncodingId
]

{ #category : #accessing }
OciClient >> oracleUnicodeEncodingId: anObject [
	oracleUnicodeEncodingId := anObject
]

{ #category : #accessing }
OciClient >> parameterPointer [
	^ parameterPointer
]

{ #category : #accessing }
OciClient >> parameterPointer: aValue [
	parameterPointer := aValue
]

{ #category : #accessing }
OciClient >> password [
	^ password
]

{ #category : #accessing }
OciClient >> password: anObject [
	password := anObject
]

{ #category : #'accessing derived' }
OciClient >> preparedStatementNamed: statementName [
]

{ #category : #public }
OciClient >> query: sqlStatementString [

	"Run a one shot SQL query in sqlStatementString and return the resulting rows"

	^ self query: sqlStatementString with: nil
]

{ #category : #public }
OciClient >> query: sqlStatementString with: inputObject [

	"Run a one shot SQL query in sqlStatementString and return the resulting rows"

	| statement |
	statement := self statementForSql: sqlStatementString.
	^ statement prepareAndExecuteWith: inputObject
]

{ #category : #'error handling' }
OciClient >> raiseErrorForErrors: errors returnValue: returnValue [
	OciError new
		errors: errors;
		returnValue: returnValue;
		signal: errors first fullDescription
]

{ #category : #'error handling' }
OciClient >> raiseNotificationForErrors: errors returnValue: returnValue [
	OciNotification new
		errors: errors;
		returnValue: returnValue;
		signal: errors first fullDescription
]

{ #category : #accessing }
OciClient >> serverHandle [
	^ serverHandle
]

{ #category : #accessing }
OciClient >> serverHandle: aHandle [
	serverHandle := aHandle
]

{ #category : #accessing }
OciClient >> serviceContextHandle [
	^ serviceContextHandle
]

{ #category : #accessing }
OciClient >> serviceContextHandle: aHandle [
	serviceContextHandle := aHandle
]

{ #category : #accessing }
OciClient >> sessionHandle [
	^ sessionHandle
]

{ #category : #accessing }
OciClient >> sessionHandle: aHandle [
	sessionHandle := aHandle
]

{ #category : #'private oci calls' }
OciClient >> signalErrorWith: aBlock [
	OciError signal: (String streamContents: [ :ws | aBlock value: ws ])
]

{ #category : #public }
OciClient >> statementForSql: sqlStatementString [
	"Prepare sqlStatementString returning an instance of OciPreparedStatement.
	A generated name will be used"
	
	^ self statementForSql: sqlStatementString named: sqlStatementString hash asString
]

{ #category : #public }
OciClient >> statementForSql: sqlStatementString named: statementName [
	"Create and return an instance of OciPreparedStatement.
	statementName must be unique"

	| statement |
	self ensureConnected.
	statement := OciPreparableStatement new.
	statement client: self.
	statement name: statementName.
	statement setStatementString: sqlStatementString.
	^ statement
]

{ #category : #accessing }
OciClient >> transactionHandle [
	^ transactionHandle
]

{ #category : #accessing }
OciClient >> transactionHandle: aHandle [
	transactionHandle := aHandle
]

{ #category : #'initialize-release' }
OciClient >> useCredentialsExternal [
	authenticationMode := OCI_CRED_EXT
]

{ #category : #'initialize-release' }
OciClient >> useCredentialsUsernamePassword [
	authenticationMode := OCI_CRED_RDBMS
]

{ #category : #accessing }
OciClient >> username [
	^ username
]

{ #category : #accessing }
OciClient >> username: anObject [
	username := anObject
]

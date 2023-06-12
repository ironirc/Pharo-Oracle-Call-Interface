Class {
	#name : #OciPreparableStatement,
	#superclass : #Object,
	#instVars : [
		'client',
		'name',
		'statementString',
		'isCached',
		'columnDescriptions',
		'statementHandle',
		'rowBuffers',
		'blockFactor',
		'rowsInBlock',
		'totalRows',
		'defineHandle',
		'bindings'
	],
	#pools : [
		'OciConstants'
	],
	#category : #'Pharo-Oracle-Call-Interface-Core'
}

{ #category : #private }
OciPreparableStatement >> addBindingByName: aName [

	^ bindings detect: [ :e | e name = aName ] ifNone: [
		  | binding |
		  binding := OciBindingByName new
			             name: aName;
			             statement: self.
		  bindings add: binding.
		  binding ]
]

{ #category : #private }
OciPreparableStatement >> addBindingByPosition: aPosition [

	| binding |
	binding := OciBindingByPosition new
		           position: aPosition;
		           statement: self.
	bindings add: binding.
	^ binding
]

{ #category : #accessing }
OciPreparableStatement >> bindings [
	^ bindings
]

{ #category : #accessing }
OciPreparableStatement >> bindings: anObject [
	bindings := anObject
]

{ #category : #accessing }
OciPreparableStatement >> blockFactor [
	^ blockFactor
]

{ #category : #accessing }
OciPreparableStatement >> blockFactor: anObject [
	blockFactor := anObject
]

{ #category : #accessing }
OciPreparableStatement >> client [
	^ client
]

{ #category : #accessing }
OciPreparableStatement >> client: anObject [
	client := anObject
]

{ #category : #'initialize-release' }
OciPreparableStatement >> close [
	self isPrepared ifFalse: [ ^ self ].
	isCached 
		ifTrue: [ 
			self ociReleaseStatementDefault ]
		ifFalse: [ 
			self ociReleaseStatementDeleteFromCache.
			self freeBindings.
			self freeRowBuffers ]
]

{ #category : #accessing }
OciPreparableStatement >> columnDescriptions [
	^ columnDescriptions
]

{ #category : #accessing }
OciPreparableStatement >> columnDescriptions: anObject [
	columnDescriptions := anObject
]

{ #category : #accessing }
OciPreparableStatement >> defineHandle [
	^ defineHandle
]

{ #category : #accessing }
OciPreparableStatement >> defineHandle: anObject [
	defineHandle := anObject
]

{ #category : #public }
OciPreparableStatement >> doWhilePrepared: aBlock [
	^self doWhilePrepared: aBlock shouldCache: true
]

{ #category : #public }
OciPreparableStatement >> doWhilePrepared: aBlock shouldCache: shouldCache [
	self ociPrepareStatement.
	^aBlock
		ensure: [ 
			"self close"
			shouldCache
				ifTrue: [ 
					self ociReleaseStatementDefault ]
				ifFalse: [ 
					self ociReleaseStatementDeleteFromCache.
					self freeBindings.
					self freeRowBuffers ] ]
]

{ #category : #public }
OciPreparableStatement >> doWithColumnDescriptorsOfCurrentStatement: aBlock [
	| probedColIdx colDescrPointer |
	probedColIdx := 0.
	[ probedColIdx := probedColIdx + 1.
	colDescrPointer := self client ociParamGet: statementHandle type: OCI_HTYPE_STMT startingAt: probedColIdx.
	colDescrPointer notNil ]
		whileTrue: [ [ aBlock value: probedColIdx value: colDescrPointer ]
				ensure: [ Oci OCIDescriptorFree: colDescrPointer type: OCI_DTYPE_PARAM ] ]
]

{ #category : #public }
OciPreparableStatement >> ensureInputBindingsForInputObject: anObject [
	self bindings do: [ :each | each ensureBindingForInputObject: anObject ].
	
]

{ #category : #'accessing derived' }
OciPreparableStatement >> errorHandle [
	^ self client errorHandle
]

{ #category : #public }
OciPreparableStatement >> executeWith: anObject [
	self ensureInputBindingsForInputObject: anObject.
	self ociExecuteStatement.
	self initializeColumnDescriptionsForCurrentStatement.
	self columnDescriptions
		ifNotNil: [ | rowsFetched rows |
			self initializeOciBuffers.
			rows := OrderedCollection new.
			[ rowsFetched := self ociStmtFetch2.
			1 to: rowsFetched do: [ :rowIndex | rows add: (self rowValueArrayForRow: rowIndex) ].
			rowsFetched isZero ] whileFalse.
			^ rows ].
	self error: 'no column descriptions retrieved after ociExecuteStatement'
]

{ #category : #public }
OciPreparableStatement >> freeBindings [
	self bindings do: [ :each | each release ]
]

{ #category : #public }
OciPreparableStatement >> freeRowBuffers [
	self rowBuffers  do: [ :each | each release ]
]

{ #category : #public }
OciPreparableStatement >> getColumnDescriptionsFromOciDescriptors [
	^ Array
		streamContents: [ :colDescrStream | 
			self
				doWithColumnDescriptorsOfCurrentStatement: [ :colIndex :colDescPointer | 
					| colDescr internalSize internalType |
					(colDescr := OciColumnDescription new)
						session: self client;
						position: colIndex;
						name: (self client ociAttributeGetString: OCI_ATTR_NAME descriptor: colDescPointer type: OCI_DTYPE_PARAM);
						maxNumberOfBytes: (internalSize := self client ociAttributeGetInteger: OCI_ATTR_DATA_SIZE descriptor: colDescPointer type: OCI_DTYPE_PARAM);
						internalType: (internalType := self client ociAttributeGetInteger: OCI_ATTR_DATA_TYPE descriptor: colDescPointer type: OCI_DTYPE_PARAM);
						type: (self client class ociTypeToSmalltalkTypeMapping at: internalType);
						precision: (self client ociAttributeGetInteger: OCI_ATTR_PRECISION descriptor: colDescPointer type: OCI_DTYPE_PARAM);
						scale: (self client ociAttributeGetInteger: OCI_ATTR_SCALE descriptor: colDescPointer type: OCI_DTYPE_PARAM);
						isNullable: (self client ociAttributeGetBoolean: OCI_ATTR_IS_NULL descriptor: colDescPointer type: OCI_DTYPE_PARAM);
						isUnicode: (self client ociAttributeGetInteger: OCI_ATTR_CHARSET_FORM descriptor: colDescPointer type: OCI_DTYPE_PARAM) == SQLCS_NCHAR.
					colDescrStream nextPut: colDescr ] ]
]

{ #category : #'initialize-release' }
OciPreparableStatement >> initialize [
	isCached := false.
	blockFactor := 100.
	defineHandle := ExternalAddress null.
]

{ #category : #public }
OciPreparableStatement >> initializeColumnDescriptionsForCurrentStatement [
	self columnDescriptions: self getColumnDescriptionsFromOciDescriptors
]

{ #category : #public }
OciPreparableStatement >> initializeOciBuffers [

	| buffers |
	buffers := self columnDescriptions collect: [ :cd | 
		           (OciBuffer
			            newForColumnDescription: cd
			            preparableStatement: self)
			           preparableStatement: self;
			           allocateExternalMemoryForBlockFactor: self blockFactor;
			           ociDefine;
			           yourself ].
	self rowBuffers: buffers
]

{ #category : #test }
OciPreparableStatement >> isPrepared [
	^ statementHandle notNil and: [ statementHandle isNull not ]
]

{ #category : #test }
OciPreparableStatement >> isSelect [
	^ self ociAttributeGetStatementType == OCI_STMT_SELECT
]

{ #category : #private }
OciPreparableStatement >> iterationCountForStatementExecution [

	"https://docs.oracle.com/database/121/LNOCI/oci17msc001.htm#LNOCI17163"

	"iters (IN)
For non-SELECT statements, the number of times this statement is executed equals iters - rowoff.
For SELECT statements, if iters is nonzero, then defines must have been done for the statement handle. 
The execution fetches iters rows into these predefined buffers and prefetches more rows depending upon the prefetch row count. 
If you do not know how many rows the SELECT statement retrieves, then set iters to zero.
This function returns an error if iters=0 for non-SELECT statements.
Note: For array DML operations, set iters <= 32767 to get better performance."

	self isSelect ifTrue: [ ^ 0 ].
	(self bindings isNil or: [ self bindings isEmpty ]) ifTrue: [ ^ 1 ].
	self flag: 'TO DO: determine max size of bound input arrays, and return this value'.
	^ 1
]

{ #category : #'accessing derived' }
OciPreparableStatement >> keyBytes [
	^self name encodeWith: #utf8
]

{ #category : #'accessing derived' }
OciPreparableStatement >> keySize [
	^self keyBytes size
]

{ #category : #accessing }
OciPreparableStatement >> name [
	^ name
]

{ #category : #accessing }
OciPreparableStatement >> name: anObject [
	name := anObject
]

{ #category : #oci }
OciPreparableStatement >> ociAttributeGetStatementType [
	^ self client ociAttributeGetInteger: OCI_ATTR_STMT_TYPE descriptor: statementHandle type: OCI_HTYPE_STMT
]

{ #category : #oci }
OciPreparableStatement >> ociExecuteStatement [

	| rv |
	rv := Oci
		      OCIStmtExecute: self client serviceContextHandle
		      stmtp: statementHandle
		      errhp: self client errorHandle
		      iters: self iterationCountForStatementExecution
		      rowoff: 0
		      snap_in: nil
		      snap_out: nil
		      mode: OCI_DEFAULT.
	rv == OCI_SUCCESS ifTrue: [ ^ self ].
	self client handleErrorsWithReturnValue: rv
]

{ #category : #oci }
OciPreparableStatement >> ociPrepareStatement [
	isCached
		ifTrue: [ self ociPrepareStatementWithCacheKey ]
		ifFalse: [ self ociPrepareStatementWithStatementString ]
]

{ #category : #oci }
OciPreparableStatement >> ociPrepareStatementWithCacheKey [
	| returnValue |
	statementHandle := ExternalAddress new.
	returnValue := Oci
		OCIStmtPrepare2: self client serviceContextHandle
		stmthp: statementHandle
		errhp: self client errorHandle
		stmttext: nil
		stmt_len: 0
		key: self keyBytes
		keylen: self keySize
		language: OCI_NTV_SYNTAX
		mode: OCI_DEFAULT.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ self ].
	self client handleErrorsWithReturnValue: returnValue
]

{ #category : #oci }
OciPreparableStatement >> ociPrepareStatementWithStatementString [
	| sqlBytes returnValue |
	sqlBytes := self statementString nullTerminatedEncodeWith: #utf8.
	statementHandle := ExternalAddress new.
	returnValue := Oci
		OCIStmtPrepare2: self client serviceContextHandle
		stmthp: statementHandle
		errhp: self client errorHandle
		stmttext: sqlBytes
		stmt_len: sqlBytes size
		key: nil
		keylen: 0
		language: OCI_NTV_SYNTAX
		mode: OCI_DEFAULT.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ self ].
	self client handleErrorsWithReturnValue: returnValue
]

{ #category : #oci }
OciPreparableStatement >> ociReleaseStatementDefault [
	self ociReleaseStatementWithMode: OCI_DEFAULT.
	isCached := true.
]

{ #category : #oci }
OciPreparableStatement >> ociReleaseStatementDeleteFromCache [
	self ociReleaseStatementWithMode: OCI_STRLS_CACHE_DELETE.
	isCached := false
]

{ #category : #oci }
OciPreparableStatement >> ociReleaseStatementWithMode: mode [
	| returnValue |
	returnValue := Oci
		OCIStmtRelease: statementHandle
		errhp: self client errorHandle
		key: self keyBytes
		keylen: self keySize
		mode: mode.
	returnValue == OCI_SUCCESS
		ifTrue: [ statementHandle := nil.
			^ self ].
	self client handleErrorsWithReturnValue: returnValue
]

{ #category : #oci }
OciPreparableStatement >> ociStmtFetch2 [
	| returnValue rowCount fetchedRows |
	returnValue := Oci
		OCIStmtFetch2: statementHandle
		errhp: self client errorHandle
		nrows: blockFactor
		orientation: OCI_FETCH_NEXT
		fetchOffset: 1
		mode: OCI_DEFAULT.
	"OCI_ATTR_ROW_COUNT contains the highest absolute row value that was fetched."
	rowCount := self client ociAttributeGetInteger: OCI_ATTR_ROW_COUNT descriptor: statementHandle type: OCI_HTYPE_STMT.
	fetchedRows := self client ociAttributeGetInteger: OCI_ATTR_ROWS_FETCHED descriptor: statementHandle type: OCI_HTYPE_STMT.
	self rowsInBlock: fetchedRows.
	self totalRows: rowCount.
	fetchedRows < blockFactor
		ifTrue: [ ^ fetchedRows ].
	({OCI_NO_DATA.
	OCI_SUCCESS.
	OCI_SUCCESS_WITH_INFO} includes: returnValue)
		ifFalse: [ self client handleErrorsWithReturnValue: returnValue ].
	^ fetchedRows
]

{ #category : #public }
OciPreparableStatement >> prepareAndExecuteWith: anObject [

	^ self doWhilePrepared: [ 
		  self executeWith: anObject ]
]

{ #category : #private }
OciPreparableStatement >> readSymbolFromStream: aStream [

	^ Symbol streamContents: [ :ws | 
		  | c |
		  c := aStream next.
		  (c isLetter or: [ c == $_ ])
			  ifTrue: [ ws nextPut: c ]
			  ifFalse: [ self error: 'unexpected char while reading symbol' ].
		  [ 
		  aStream atEnd not and: [ 
			  aStream peek isAlphaNumeric or: [ aStream peek == $_ ] ] ] whileTrue: [ 
			  c := aStream next.
			  ws nextPut: c ] ]
]

{ #category : #accessing }
OciPreparableStatement >> rowBuffers [
	^ rowBuffers
]

{ #category : #accessing }
OciPreparableStatement >> rowBuffers: anObject [
	rowBuffers := anObject
]

{ #category : #test }
OciPreparableStatement >> rowValueArrayForRow: rowIndex [
	^ self rowBuffers collect: [ :rb | rb valueAtRow: rowIndex ]
]

{ #category : #accessing }
OciPreparableStatement >> rowsInBlock [
	^ rowsInBlock
]

{ #category : #accessing }
OciPreparableStatement >> rowsInBlock: anObject [
	rowsInBlock := anObject
]

{ #category : #private }
OciPreparableStatement >> setStatementString: aString [

	| rs ch prevCh statement |
	bindings := OrderedCollection new.

	rs := aString readStream.
	ch := $?.
	statement := String streamContents: [ :ws | 
		             [ rs atEnd ] whileFalse: [ 
			             prevCh := ch.
			             ch := rs next.
			             ({ $'. $" } includes: ch)
				             ifTrue: [ "single or double quoted strings can not contain bindings, just copy"
					             ws nextPut: ch.
					             ws nextPutAll: (rs upTo: ch).
					             ws nextPut: ch ]
				             ifFalse: [ 
					             ch == $?
						             ifTrue: [ 
							             | binding |
							             "relative positioned ? marker"
							             binding := self addBindingByPosition: bindings size + 1.
							             binding writeMarkerOn: ws ]
						             ifFalse: [ 
							             (ch == $: and: [ 
								              prevCh isAlphaNumeric not and: [ 
									              prevCh ~= $: and: [ 
										              rs atEnd not and: [ rs peek isAlphaNumeric ] ] ] ])
								             ifTrue: [ 
									             | binding |
									             "It's a valid : marker"
									             binding := rs peek isDigit
										                   ifTrue: [ "absolute positioned marker " 
											                   self addBindingByPosition:
												                   (Integer readFrom: rs) ]
										                   ifFalse: [ "named marker" 
											                   self addBindingByName:
												                   (self readSymbolFromStream: rs) ].
									             binding writeMarkerOn: ws ]
								             ifFalse: [ ws nextPut: ch ] ] ] ] ].
	self statementString: statement
]

{ #category : #accessing }
OciPreparableStatement >> statementHandle [
	^ statementHandle
]

{ #category : #accessing }
OciPreparableStatement >> statementHandle: anObject [
	statementHandle := anObject
]

{ #category : #accessing }
OciPreparableStatement >> statementString [
	^ statementString
]

{ #category : #accessing }
OciPreparableStatement >> statementString: anObject [
	statementString := anObject
]

{ #category : #accessing }
OciPreparableStatement >> totalRows [
	^ totalRows
]

{ #category : #accessing }
OciPreparableStatement >> totalRows: anObject [
	totalRows := anObject
]

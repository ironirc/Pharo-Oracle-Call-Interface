Class {
	#name : #OciBuffer,
	#superclass : #Object,
	#instVars : [
		'columnDescription',
		'session',
		'preparableStatement',
		'position',
		'externalType',
		'baseAddressOfLengthsArray',
		'baseAddressOfReturnCodes',
		'baseAddressOfIndicators',
		'baseAddressOfBufferArray',
		'singleBufferSize'
	],
	#pools : [
		'OciConstants',
		'OciConstantsExternalDataTypes',
		'OciConstantsInternalDataTypes'
	],
	#category : 'Pharo-Oracle-Call-Interface-Buffers'
}

{ #category : #private }
OciBuffer class >> concreteClassForColumnDescription: cd client: aClient [
	"cd isLargeObject
		ifTrue: [ ^ OciBufferLargeObject ].
	cd isCursor
		ifTrue: [ ^ OciBufferRefCursor ]."
"TODO
	intlType == INTERNAL_DATATYPE_BINARY_FLOAT
		ifTrue: [ extlType := SQLT_BFLOAT.
			elemSize := 4 ].
	intlType == INTERNAL_DATATYPE_BINARY_DOUBLE
		ifTrue: [ extlType := SQLT_BDOUBLE.
			elemSize := 8 ].
	
	(intlType == SQLT_RID or: [ intlType == SQLT_RDD ])
		ifTrue: [ ROWID can be as much as 256 bytes in string form.
			extlType := SQLT_CHR.
			elemSize := 256 ]."


	(cd internalType == SQLT_TIMESTAMP or: [ cd internalType == SQLT_TIMESTAMP_TZ ])
		ifTrue: [ "self halt." "probably a different kind of buffer needed?"
			^ OciBufferDate ].
		
	cd internalType == SQLT_DAT
		ifTrue: [ ^ OciBufferDate ].
	cd internalType == INTERNAL_DATATYPE_VARCHAR2
		ifTrue: [ cd maxNumberOfBytes > aClient  maxVarcharStringSize
				ifTrue: [ ^ OciBufferLong ]
				ifFalse: [ ^ OciBufferVarchar2 ] ].
	cd internalType == INTERNAL_DATATYPE_CHAR
		ifTrue: [ ^ OciBufferChar ]. 
	cd internalType == INTERNAL_DATATYPE_LONG
		ifTrue: [ ^ OciBufferLong ].
	cd internalType == INTERNAL_DATATYPE_RAW
		ifTrue: [ cd maxNumberOfBytes > aClient maxVarcharStringSize
				ifTrue: [ ^ OciBufferLongRaw ]
				ifFalse: [ ^ OciBufferRaw ] ].
	cd internalType == INTERNAL_DATATYPE_NUMBER
		ifTrue: [ (cd scale == -127 and: [ cd precision ~= 0 ])
				ifTrue: [ cd precision <= 26
						ifTrue: [ ^ OciBufferFloat ].
					cd precision <= 46
						ifTrue: [ ^ OciBufferFloatDouble ] ] ].
	cd isScaledDecimal
		ifTrue: [ ^ OciBufferScaledDecimal ].
	cd isInteger
		ifTrue: [ ^ OciBufferInteger ].
	self error: 'unable to determine the concrete oci buffer class'
]

{ #category : #'instance creation' }
OciBuffer class >> newForColumnDescription: cd preparableStatement: aPreparableStatement [
	| buffer |
	buffer := (self concreteClassForColumnDescription: cd client: aPreparableStatement client) new.
	buffer
		preparableStatement: aPreparableStatement;
		initializeWithColumnDescription: cd.
	^ buffer
]

{ #category : #malloc }
OciBuffer >> allocateExternalMemoryForBlockFactor: aBlockFactor [

	baseAddressOfBufferArray := ExternalAddress gcallocate:
		                            singleBufferSize * aBlockFactor.
	baseAddressOfIndicators := ExternalAddress gcallocate:
		                           aBlockFactor * 2.
	self allocateMemoryForLengthsArrayForBlockFactor: aBlockFactor.
	baseAddressOfReturnCodes := ExternalAddress gcallocate:
		                            aBlockFactor * 2
]

{ #category : #malloc }
OciBuffer >> allocateMemoryForLengthsArrayForBlockFactor: aBlockFactor [
	baseAddressOfLengthsArray := ExternalAddress gcallocate: aBlockFactor * 2
]

{ #category : #accessing }
OciBuffer >> baseAddressOfBufferArray [
	^ baseAddressOfBufferArray
]

{ #category : #accessing }
OciBuffer >> baseAddressOfBufferArray: anObject [
	baseAddressOfBufferArray := anObject
]

{ #category : #'accessing derived' }
OciBuffer >> client [
	^ self preparableStatement client 
]

{ #category : #accessing }
OciBuffer >> columnDescription [
	^ columnDescription
]

{ #category : #accessing }
OciBuffer >> columnDescription: anObject [
	columnDescription := anObject
]

{ #category : #'accessing derived' }
OciBuffer >> defineHandle [
	"
https://docs.oracle.com/cd/E11882_01/appdev.112/e10646.pdf
Bind and define handles are implicitly allocated by the OCI library,
and are transparently reused if the bind or define operation is repeated.
The actual value of the bind or define handle is needed by the application
for the advanced bind or define operations described in Chapter 5.
The handles are freed when the statement handle is freed or when a new statement is prepared on the statement handle.
Explicitly allocating bind or define handles may lead to memory leaks.
Explicitly freeing bind or define handles may cause abnormal program termination"

	^self preparableStatement  defineHandle
]

{ #category : #accessing }
OciBuffer >> externalType [
	^ externalType
]

{ #category : #private }
OciBuffer >> handleErrorsWithReturnValue: rv [
	^ self client handleErrorsWithReturnValue: rv
]

{ #category : #private }
OciBuffer >> initializeWithColumnDescription: cd [
	columnDescription := cd. 
	position := cd position
]

{ #category : #private }
OciBuffer >> ociDefine [
	| rv |
	rv := Oci
		OCIDefineByPos: self preparableStatement  statementHandle
		defnpp: self defineHandle
		errhp: self preparableStatement errorHandle
		position: position
		valuep: baseAddressOfBufferArray
		value_sz: singleBufferSize
		dty: externalType
		indp: baseAddressOfIndicators
		rlenp: baseAddressOfLengthsArray
		rcodep: baseAddressOfReturnCodes
		mode: OCI_DEFAULT.
	rv == OCI_SUCCESS
		ifTrue: [ ^ self ].
	self handleErrorsWithReturnValue: rv
]

{ #category : #accessing }
OciBuffer >> preparableStatement [
	^ preparableStatement
]

{ #category : #accessing }
OciBuffer >> preparableStatement: anObject [
	preparableStatement := anObject
]

{ #category : #'initialize-release' }
OciBuffer >> release [
	super release.
	baseAddressOfLengthsArray := nil.
	baseAddressOfReturnCodes := nil.
	baseAddressOfIndicators := nil.
	baseAddressOfBufferArray := nil
]

{ #category : #accessing }
OciBuffer >> singleBufferSize [
	^ singleBufferSize
]

{ #category : #accessing }
OciBuffer >> singleBufferSize: anObject [
	singleBufferSize := anObject
]

{ #category : #accessing }
OciBuffer >> valueAtRow: rowIndex [
	baseAddressOfReturnCodes
		ifNotNil: [ | returnCode |
			returnCode := baseAddressOfReturnCodes unsignedShortAt: (rowIndex - 1) * 2 + 1.
			returnCode == OCI_RTN_CODE_NULL_DATA
				ifTrue: [ ^ nil ].
			(returnCode == OCI_SUCCESS or: [ returnCode == OCI_RTN_CODE_TRUNCATED_DATA ])
				ifFalse: [ self
						error:
							'oci error at rownum: ' , rowIndex displayString , ' for column: ' , self columnDescription name , ' error code: '
								, returnCode displayString ] ].
	^ self valueFromBufferAtRow: rowIndex
]

{ #category : #accessing }
OciBuffer >> valueFromBufferAtRow: rowIndex [
	^ self subclassResponsibility
]

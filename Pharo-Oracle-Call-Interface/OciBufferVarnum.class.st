Class {
	#name : #OciBufferVarnum,
	#superclass : #OciBufferWithReusableValueBuffer,
	#category : 'Pharo-Oracle-Call-Interface-Buffers'
}

{ #category : #'as yet unclassified' }
OciBufferVarnum class >> externalDatabaseType [
	^SQLT_VNU
]

{ #category : #'initialise-release' }
OciBufferVarnum >> initialize [
	super initialize.
	singleBufferSize := 22.
	valueBuffer := ByteArray new: singleBufferSize
]

{ #category : #accessing }
OciBufferVarnum >> initializeWithColumnDescription: cd [
	super initializeWithColumnDescription: cd. 
	externalType := SQLT_VNU.

]

{ #category : #accessing }
OciBufferVarnum >> setSingleBufferSizeForValue: aValue [
]

{ #category : #accessing }
OciBufferVarnum >> value: aValue toBufferAtRow: rowIndex [
	| byteArray |
	byteArray := aValue asOciVarNumByteArray.
	LibC memCopy: byteArray to: (self targetAddressForRow: rowIndex) size: byteArray size
]

{ #category : #accessing }
OciBufferVarnum >> valueFromBufferAtRow: rowIndex [
	LibC memCopy: (self targetAddressForRow: rowIndex) to: valueBuffer size: 22.
	^ valueBuffer decodedFromOciVarNum
]

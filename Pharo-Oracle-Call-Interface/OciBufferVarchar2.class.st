Class {
	#name : #OciBufferVarchar2,
	#superclass : #OciBufferEncodedString,
	#category : 'Pharo-Oracle-Call-Interface-Buffers'
}

{ #category : #constants }
OciBufferVarchar2 class >> externalDatabaseType [
	self flag: 'revise'.
	"previously used SQLT_CHR = VARCHAR2, which might be correct"
	"also see OciBufferVarchar2>>#setSingleBufferSizeForValue:"
	^SQLT_STR "Null-Terminated string"
]

{ #category : #'initalize-release' }
OciBufferVarchar2 >> initializeWithColumnDescription: cd [
	super initializeWithColumnDescription: cd.
	externalType := SQLT_CHR.
	singleBufferSize := cd maxNumberOfBytes.

	self needsDoubleBufferSize
		ifTrue: [ singleBufferSize := singleBufferSize * 2 ]
]

{ #category : #initialization }
OciBufferVarchar2 >> setSingleBufferSizeForValue: aValue [
	self flag: 'revise'.
	"We could use aValue's size to set the buffer size. But when this buffer gets reused for a larger value, this gives problems.
	Also take a look at OciBufferVarchar2 class>>#externalDatabaseType "
	singleBufferSize := "(self encodeStringAsByteArray: aValue) size" 4000
]

{ #category : #accessing }
OciBufferVarchar2 >> value: aValue toBufferAtRow: rowIndex [
	| byteArray |
	byteArray := self encodeStringAsByteArray: aValue.
	LibC memCopy: byteArray to: baseAddressOfBufferArray + ((rowIndex - 1) * singleBufferSize) size: byteArray size.
	baseAddressOfLengthsArray unsignedShortAt: (rowIndex - 1) * 2 + 1 put: byteArray size
]

{ #category : #accessing }
OciBufferVarchar2 >> valueFromBufferAtRow: rowIndex [
	| actualValueSize valueBuffer |
	actualValueSize := baseAddressOfLengthsArray unsignedShortAt: (rowIndex - 1) * 2 + 1.
	valueBuffer := ByteArray new: actualValueSize.
	LibC memCopy: baseAddressOfBufferArray + ((rowIndex - 1) * singleBufferSize) to: valueBuffer size: actualValueSize.
	^ self decodedValueBuffer: valueBuffer
]

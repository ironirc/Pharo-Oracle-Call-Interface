Class {
	#name : #OciBufferLong,
	#superclass : #OciBufferEncodedString,
	#category : 'Pharo-Oracle-Call-Interface-Buffers'
}

{ #category : #accessing }
OciBufferLong >> allocateMemoryForLengthsArrayForBlockFactor: anObject [
	"no need, length is encoded into the value's structure as the first 4 bytes"
]

{ #category : #accessing }
OciBufferLong >> initializeWithColumnDescription: cd [
	super initializeWithColumnDescription: cd.
	externalType := SQLT_LVC.
	singleBufferSize := 4 + (self client bufferSizeForLongType roundUpTo: 4).
	self needsDoubleBufferSize
		ifTrue: [ singleBufferSize := singleBufferSize * 2 ]
]

{ #category : #accessing }
OciBufferLong >> value: aValue toBufferAtRow: rowIndex [
	| byteArray byteOffsetForRow |
	byteArray := self encodeStringAsByteArray: aValue.
	byteOffsetForRow := (rowIndex - 1) * singleBufferSize.
	baseAddressOfBufferArray unsignedShortAt: byteOffsetForRow + 1 put: byteArray size.
	LibC memCopy: byteArray to: baseAddressOfBufferArray + byteOffsetForRow + 4 size: byteArray size
]

{ #category : #accessing }
OciBufferLong >> valueFromBufferAtRow: rowIndex [
	| byteOffsetForRow actualValueSize valueBuffer |
	byteOffsetForRow := (rowIndex - 1) * singleBufferSize.
	actualValueSize := baseAddressOfBufferArray unsignedShortAt: byteOffsetForRow + 1.
	valueBuffer := ByteArray new: actualValueSize.
	LibC memCopy: baseAddressOfBufferArray + byteOffsetForRow + 4 to: valueBuffer size: actualValueSize.
	^ self decodedValueBuffer: valueBuffer
]

Class {
	#name : #OciBufferLongRaw,
	#superclass : #OciBuffer,
	#category : 'Pharo-Oracle-Call-Interface-Buffers'
}

{ #category : #accessing }
OciBufferLongRaw >> allocateMemoryForLengthsArrayForBlockFactor: anObject [
	"no need, length is encoded into the value's structure as the first 4 bytes"

	
]

{ #category : #accessing }
OciBufferLongRaw >> initializeWithColumnDescription: cd [
	super initializeWithColumnDescription: cd.
	externalType := SQLT_LBI.
	singleBufferSize := 4 + (self client bufferSizeForLongType roundUpTo: 4)
]

{ #category : #accessing }
OciBufferLongRaw >> valueFromBufferAtRow: rowIndex [
	| byteOffsetForRow actualValueSize valueBuffer |
	byteOffsetForRow := (rowIndex - 1) * singleBufferSize.
	actualValueSize := baseAddressOfBufferArray unsignedShortAt: byteOffsetForRow + 1.
	valueBuffer := ByteArray new: actualValueSize.
	LibC memCopy: baseAddressOfBufferArray + byteOffsetForRow + 4 to: valueBuffer size: actualValueSize.
	^ valueBuffer
]

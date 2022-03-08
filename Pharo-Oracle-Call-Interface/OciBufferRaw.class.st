Class {
	#name : #OciBufferRaw,
	#superclass : #OciBuffer,
	#category : 'Pharo-Oracle-Call-Interface-Buffers'
}

{ #category : #'initalize-release' }
OciBufferRaw >> initializeWithColumnDescription: cd [
	super initializeWithColumnDescription: cd.
	externalType := SQLT_BIN.
	singleBufferSize := cd maxNumberOfBytes.
]

{ #category : #accessing }
OciBufferRaw >> valueFromBufferAtRow: rowIndex [
	| actualValueSize valueBuffer |
	actualValueSize := baseAddressOfLengthsArray unsignedShortAt: (rowIndex - 1) * 2 + 1.
	valueBuffer := ByteArray new: actualValueSize.
	LibC memCopy: baseAddressOfBufferArray + ((rowIndex - 1) * singleBufferSize) to: valueBuffer size: actualValueSize.
	^ valueBuffer
]

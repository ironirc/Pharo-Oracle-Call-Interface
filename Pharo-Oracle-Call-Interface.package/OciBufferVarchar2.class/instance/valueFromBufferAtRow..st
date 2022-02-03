accessing
valueFromBufferAtRow: rowIndex
	| actualValueSize valueBuffer |
	actualValueSize := baseAddressOfLengthsArray unsignedShortAt: (rowIndex - 1) * 2 + 1.
	valueBuffer := ByteArray new: actualValueSize.
	LibC memCopy: baseAddressOfBufferArray + ((rowIndex - 1) * singleBufferSize) to: valueBuffer size: actualValueSize.
	^ self decodedValueBuffer: valueBuffer
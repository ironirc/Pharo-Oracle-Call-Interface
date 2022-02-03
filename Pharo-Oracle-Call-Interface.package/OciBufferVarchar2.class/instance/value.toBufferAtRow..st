accessing
value: aValue toBufferAtRow: rowIndex
	| byteArray |
	byteArray := self encodeStringAsByteArray: aValue.
	LibC memCopy: byteArray to: baseAddressOfBufferArray + ((rowIndex - 1) * singleBufferSize) size: byteArray size.
	baseAddressOfLengthsArray unsignedShortAt: (rowIndex - 1) * 2 + 1 put: byteArray size
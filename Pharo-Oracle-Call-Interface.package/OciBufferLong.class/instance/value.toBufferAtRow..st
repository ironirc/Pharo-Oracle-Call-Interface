accessing
value: aValue toBufferAtRow: rowIndex
	| byteArray byteOffsetForRow |
	byteArray := self encodeStringAsByteArray: aValue.
	byteOffsetForRow := (rowIndex - 1) * singleBufferSize.
	baseAddressOfBufferArray unsignedShortAt: byteOffsetForRow + 1 put: byteArray size.
	LibC memCopy: byteArray to: baseAddressOfBufferArray + byteOffsetForRow + 4 size: byteArray size
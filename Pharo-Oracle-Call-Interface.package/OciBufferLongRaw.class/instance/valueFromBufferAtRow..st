accessing
valueFromBufferAtRow: rowIndex
	| byteOffsetForRow actualValueSize valueBuffer |
	byteOffsetForRow := (rowIndex - 1) * singleBufferSize.
	actualValueSize := baseAddressOfBufferArray unsignedShortAt: byteOffsetForRow + 1.
	valueBuffer := ByteArray new: actualValueSize.
	LibC memCopy: baseAddressOfBufferArray + byteOffsetForRow + 4 to: valueBuffer size: actualValueSize.
	^ valueBuffer
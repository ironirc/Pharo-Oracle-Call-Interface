accessing
value: aValue toBufferAtRow: rowIndex
	| byteArray |
	byteArray := aValue asOciVarNumByteArray.
	LibC memCopy: byteArray to: (self targetAddressForRow: rowIndex) size: byteArray size
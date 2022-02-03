malloc
value: aValue toBufferAtRow: rowIndex
	| byteArray |
	byteArray := aValue asOciDateByteArray.
	LibC memCopy: byteArray to: (self targetAddressForRow: rowIndex) size: byteArray size 
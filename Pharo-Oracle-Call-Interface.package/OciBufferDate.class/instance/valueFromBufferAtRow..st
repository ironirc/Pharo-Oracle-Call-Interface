malloc
valueFromBufferAtRow: rowIndex
	LibC memCopy: (self targetAddressForRow: rowIndex) to: valueBuffer size: singleBufferSize.
	^ valueBuffer decodedFromOciDate "returns a DateAndTime object" 
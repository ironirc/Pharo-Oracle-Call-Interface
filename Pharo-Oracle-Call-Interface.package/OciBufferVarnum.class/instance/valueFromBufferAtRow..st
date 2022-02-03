accessing
valueFromBufferAtRow: rowIndex
	LibC memCopy: (self targetAddressForRow: rowIndex) to: valueBuffer size: 22.
	^ valueBuffer decodedFromOciVarNum
accessing
targetAddressForRow: rowIndex
	^ baseAddressOfBufferArray + ((rowIndex - 1) * singleBufferSize)
accessing
valueFromBufferAtRow: rowIndex
	^ScaledDecimal newFromNumber: (super valueFromBufferAtRow: rowIndex) scale: scale
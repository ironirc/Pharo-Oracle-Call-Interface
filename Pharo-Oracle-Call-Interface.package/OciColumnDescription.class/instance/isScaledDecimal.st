testing
isScaledDecimal
	^ self type == #Number and: [ self scale isZero not ]
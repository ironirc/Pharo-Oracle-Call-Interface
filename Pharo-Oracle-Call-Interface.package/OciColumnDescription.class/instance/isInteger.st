testing
isInteger
	^ self type == #Number and: [ self scale isZero ]
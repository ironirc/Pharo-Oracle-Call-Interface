accessing derived
blockFactor
	^ self preparableStatement ifNil: [ 1 ] ifNotNil: [ :ps | ps blockFactor ]
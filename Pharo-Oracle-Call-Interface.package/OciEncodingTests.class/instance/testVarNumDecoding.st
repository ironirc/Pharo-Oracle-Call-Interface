tests
testVarNumDecoding
	self valuePairsToTest do: [ :assoc | self assert: assoc key decodedFromOciVarNum equals: assoc value ]
tests
testVarNumEncoding
	self valuePairsToTest
		do: [ :assoc | self assert: assoc value asOciVarNumByteArray equals: ("self paddWithTrailingZerosUntilSize22:" assoc key) ]
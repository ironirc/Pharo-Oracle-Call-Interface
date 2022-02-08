tests
testConnectDisconnect
	client connect.
	self assert: client isConnected.
	client close.
	self deny: client isConnected
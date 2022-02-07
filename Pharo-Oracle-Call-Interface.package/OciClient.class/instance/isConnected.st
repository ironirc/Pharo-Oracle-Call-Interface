testing
isConnected
	^ self sessionHandle notNil and: [ self sessionHandle isNull not ]
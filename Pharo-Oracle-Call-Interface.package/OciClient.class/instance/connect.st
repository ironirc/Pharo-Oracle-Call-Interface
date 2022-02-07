initialize-release
connect
	self isConnected ifTrue: [ ^ self ].
	self initializeOciHandlesAndStuff
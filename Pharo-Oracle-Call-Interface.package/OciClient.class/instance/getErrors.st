error handling
getErrors
	^ self errorHandle
		ifNil: [ self error: 'unable to get errors because error handle is not initialized' ]
		ifNotNil: [ self getConnectionErrors ]
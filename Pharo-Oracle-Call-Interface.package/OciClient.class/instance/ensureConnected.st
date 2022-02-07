private
ensureConnected

	self isConnected ifFalse: [ self connect ]
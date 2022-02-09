initialize-release
close
	self isPrepared ifFalse: [ ^ self ].
	isCached 
		ifTrue: [ 
			self ociReleaseStatementDefault ]
		ifFalse: [ 
			self ociReleaseStatementDeleteFromCache.
			self freeBindings.
			self freeRowBuffers ]
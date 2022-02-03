public
doWhilePrepared: aBlock shouldCache: shouldCache
	self ociPrepareStatement.
	aBlock
		ensure: [ shouldCache
				ifTrue: [ self ociReleaseStatementDefault ]
				ifFalse: [ self ociReleaseStatementDeleteFromCache.
					self freeBindings.
					self freeRowBuffers ] ]
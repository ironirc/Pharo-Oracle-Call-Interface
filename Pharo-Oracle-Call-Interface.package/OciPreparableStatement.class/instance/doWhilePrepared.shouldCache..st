public
doWhilePrepared: aBlock shouldCache: shouldCache
	self ociPrepareStatement.
	aBlock
		ensure: [ 
			"self close"
			shouldCache
				ifTrue: [ 
					self ociReleaseStatementDefault ]
				ifFalse: [ 
					self ociReleaseStatementDeleteFromCache.
					self freeBindings.
					self freeRowBuffers ] ]
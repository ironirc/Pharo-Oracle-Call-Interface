initialize-release
close
	self isConnected ifTrue: [ ^ self ].
	self ociSessionEnd.
	self ociServerDetach.
	self ociFreeAllHandles.
initialize-release
close
	self isConnected ifFalse: [ ^ self ].
	self ociSessionEnd.
	self ociServerDetach.
	self ociFreeAllHandles.
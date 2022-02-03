oci calls
ociAllocateAllHandles
	self ociAllocateErrorHandle.
	self ociAllocateServiceContextHandle.
	self ociAllocateServerHandle.
	self ociAllocateSessionHandle.
	self ociAllocateTransactionHandle
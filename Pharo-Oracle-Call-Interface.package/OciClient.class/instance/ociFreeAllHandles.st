oci calls
ociFreeAllHandles
	self ociFreeTransactionHandle.
	self ociFreeSessionHandle.
	self ociFreeServerHandle.
	self ociFreeServiceContextHandle.
	self ociFreeErrorHandle
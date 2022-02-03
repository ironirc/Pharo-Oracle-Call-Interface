oci
ociPrepareStatement
	isCached
		ifTrue: [ self ociPrepareStatementWithCacheKey ]
		ifFalse: [ self ociPrepareStatementWithStatementString ]
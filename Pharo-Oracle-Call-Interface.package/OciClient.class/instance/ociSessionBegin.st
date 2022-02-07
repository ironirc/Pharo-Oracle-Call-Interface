private oci calls
ociSessionBegin
	| returnValue |
	returnValue := Oci
		OCISessionBegin: self serviceContextHandle
		errhp: self errorHandle
		usrhp: self sessionHandle
		credt: authenticationMode
		mode: OCI_STMT_CACHE.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ self ].
	self handleErrorsWithReturnValue: returnValue
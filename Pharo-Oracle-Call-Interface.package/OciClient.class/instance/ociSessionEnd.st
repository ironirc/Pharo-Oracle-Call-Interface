private oci calls
ociSessionEnd
	| returnValue |
	returnValue := Oci
		OCISessionEnd: self serviceContextHandle
		errhp: self errorHandle
		usrhp: self sessionHandle
		mode: OCI_DEFAULT.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ self ].
	self handleErrorsWithReturnValue: returnValue
oci calls
ociParamGet: hDescriptor type: descriptorType startingAt: position
	| returnValue externalAddress |
	externalAddress := ExternalAddress new.
	returnValue := Oci
		OCIParamGet: hDescriptor
		htype: descriptorType
		errhp: self errorHandle
		parmdpp: externalAddress
		pos: position.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ externalAddress "always release the descriptor with OCIDescriptorFree (type OCI_DTYPE_PARAM)" ].
	returnValue == OCI_ERROR
		ifTrue: [ ^ nil ]
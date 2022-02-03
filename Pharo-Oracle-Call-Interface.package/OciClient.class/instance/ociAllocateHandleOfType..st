oci calls
ociAllocateHandleOfType: handleType
	| newHandle returnValue |
	newHandle := ExternalAddress new.
	returnValue := Oci
		OCIHandleAlloc: self environmentHandle
		hndlpp: newHandle
		type: handleType
		xtramem_sz: 0
		usrmempp: nil.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ newHandle ].
	self signalErrorWith: [ :ws | ws << 'OCIHandleAlloc for type: ' << handleType << ' failed. (errCode: ' << returnValue << ')' ]
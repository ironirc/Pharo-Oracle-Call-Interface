private oci calls
ociServerDetach
	| returnValue |
	returnValue := Oci OCIServerDetach: self serverHandle errhp: self errorHandle mode: OCI_DEFAULT.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ self ].
	self handleErrorsWithReturnValue: returnValue.
	
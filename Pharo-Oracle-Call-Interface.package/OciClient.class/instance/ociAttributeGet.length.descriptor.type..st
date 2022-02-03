oci calls
ociAttributeGet: attributeType length: sizep descriptor: descriptor type: descriptorType
	| returnValue attributep |
	attributep := ByteArray new: 4.
	returnValue := Oci
		OCIAttrGet: descriptor
		trghndltyp: descriptorType
		attributep: attributep
		sizep: sizep
		attrtype: attributeType
		errhp: self errorHandle.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ attributep ].
	self handleErrorsWithReturnValue: returnValue
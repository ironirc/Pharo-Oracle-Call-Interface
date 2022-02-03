oci calls
ociAttributeSet: attributePointer size: size type: anAttributeType descriptor: aDescriptor type: aDescriptorType
	| returnValue |
	returnValue := Oci
		OCIAttrSet: aDescriptor
		trghndltyp: aDescriptorType
		attributep: attributePointer
		size: size
		attrtype: anAttributeType
		errhp: self errorHandle.
	returnValue == OCI_SUCCESS
		ifFalse: [ self handleErrorsWithReturnValue: returnValue ]
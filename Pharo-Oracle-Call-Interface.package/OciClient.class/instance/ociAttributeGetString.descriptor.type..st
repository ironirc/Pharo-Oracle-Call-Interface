oci calls
ociAttributeGetString: attributeType descriptor: descriptor type: descriptorType
	| attributeBuffer |
	attributeBuffer := self
		ociAttributeGet: attributeType
		length: nil
		descriptor: descriptor
		type: descriptorType.
	^ attributeBuffer asExternalPointer readStringUTF8
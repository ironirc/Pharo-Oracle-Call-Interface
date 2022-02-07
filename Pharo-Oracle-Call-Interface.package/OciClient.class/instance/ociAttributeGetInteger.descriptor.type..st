private oci calls
ociAttributeGetInteger: attributeType descriptor: descriptor type: descriptorType
	| attributeBuffer |
	attributeBuffer := self
		ociAttributeGet: attributeType
		length: nil
		descriptor: descriptor
		type: descriptorType.
	^ attributeBuffer unsignedShortAt: 1
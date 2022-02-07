private oci calls
ociAttributeGetBoolean: attributeType descriptor: descriptor type: descriptorType
	^ (self ociAttributeGetInteger: attributeType descriptor: descriptor type: descriptorType) == 1
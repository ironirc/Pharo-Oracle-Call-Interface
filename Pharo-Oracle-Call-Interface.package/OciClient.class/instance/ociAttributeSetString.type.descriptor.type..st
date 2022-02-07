private oci calls
ociAttributeSetString: aString type: anAttributeType descriptor: aDescriptor type: aDescriptorType
	| encodedString |
	encodedString := aString encodeWith: #utf8.
	self
		ociAttributeSet: encodedString
		size: encodedString size
		type: anAttributeType
		descriptor: aDescriptor
		type: aDescriptorType
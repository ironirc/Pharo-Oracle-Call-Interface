oci calls
ociAttributeSetInteger: anInteger type: anAttributeType descriptor: aDescriptor type: aDescriptorType
	self
		ociAttributeSet: (ByteArray with: anInteger)
		size: 1
		type: anAttributeType
		descriptor: aDescriptor
		type: aDescriptorType
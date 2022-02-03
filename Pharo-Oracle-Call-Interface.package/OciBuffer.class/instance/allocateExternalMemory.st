malloc
allocateExternalMemory
	baseAddressOfBufferArray := ExternalAddress gcallocate: singleBufferSize * self blockFactor.
	baseAddressOfIndicators := ExternalAddress gcallocate: self blockFactor * 2.
	self allocateMemoryForLengthsArray.
	baseAddressOfReturnCodes := ExternalAddress gcallocate: self blockFactor * 2
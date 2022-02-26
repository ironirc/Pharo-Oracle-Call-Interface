malloc
allocateExternalMemoryForBlockFactor: aBlockFactor

	baseAddressOfBufferArray := ExternalAddress gcallocate:
		                            singleBufferSize * aBlockFactor.
	baseAddressOfIndicators := ExternalAddress gcallocate:
		                           aBlockFactor * 2.
	self allocateMemoryForLengthsArrayForBlockFactor: aBlockFactor.
	baseAddressOfReturnCodes := ExternalAddress gcallocate:
		                            aBlockFactor * 2
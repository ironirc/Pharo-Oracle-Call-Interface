malloc
allocateMemoryForLengthsArrayForBlockFactor: aBlockFactor
	baseAddressOfLengthsArray := ExternalAddress gcallocate: aBlockFactor * 2
accessing
initializeWithColumnDescription: cd
	super initializeWithColumnDescription: cd.
	externalType := SQLT_LBI.
	singleBufferSize := 4 + (self client bufferSizeForLongType roundUpTo: 4)
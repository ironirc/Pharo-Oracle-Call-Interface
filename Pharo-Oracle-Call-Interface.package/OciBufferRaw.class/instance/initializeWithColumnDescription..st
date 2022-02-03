initalize-release
initializeWithColumnDescription: cd
	super initializeWithColumnDescription: cd.
	externalType := SQLT_BIN.
	singleBufferSize := cd maxNumberOfBytes.
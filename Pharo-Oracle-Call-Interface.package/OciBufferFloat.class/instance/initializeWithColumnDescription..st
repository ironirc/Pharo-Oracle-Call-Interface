accessing
initializeWithColumnDescription: cd
	super initializeWithColumnDescription: cd.
	externalType := SQLT_FLT.
	singleBufferSize := 4
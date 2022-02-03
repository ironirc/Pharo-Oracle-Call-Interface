malloc
initializeWithColumnDescription: cd
	super initializeWithColumnDescription: cd.
	externalType := SQLT_DAT.
	singleBufferSize := 7.
	valueBuffer := ByteArray new: 7 
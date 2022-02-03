initalize-release
initializeWithColumnDescription: cd
	super initializeWithColumnDescription: cd.
	externalType := SQLT_CHR.
	singleBufferSize := cd maxNumberOfBytes.

	self needsDoubleBufferSize
		ifTrue: [ singleBufferSize := singleBufferSize * 2 ]
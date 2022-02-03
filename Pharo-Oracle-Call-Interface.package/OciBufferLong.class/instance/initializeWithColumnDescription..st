accessing
initializeWithColumnDescription: cd
	super initializeWithColumnDescription: cd.
	externalType := SQLT_LVC.
	singleBufferSize := 4 + (self client bufferSizeForLongType roundUpTo: 4).
	self needsDoubleBufferSize
		ifTrue: [ singleBufferSize := singleBufferSize * 2 ]
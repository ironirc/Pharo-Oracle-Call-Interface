private oci calls
signalErrorWith: aBlock
	OciError signal: (String streamContents: [ :ws | aBlock value: ws ])
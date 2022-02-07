private oci calls
ociErrorGet: handleOrNil type: errorType at: errorIndex
	| buffer rtval bufferErrorCode |
	buffer := ByteArray new: 512.
	bufferErrorCode := ByteArray new: 4.
	rtval := Oci
		OCIErrorGet: handleOrNil
		recordno: errorIndex
		sqlstate: #dummyValue
		errcodep: bufferErrorCode
		bufp: buffer
		bufsiz: buffer size
		type: errorType.
	rtval == OCI_NO_DATA ifTrue: [ ^nil ].
	rtval == OCI_SUCCESS
		ifTrue: [ ^ OciErrorDescription new
				code: (bufferErrorCode unsignedShortAt: 1);
				description: (String streamContents: [ :ws | ws << (buffer utf8Decoded readStream upTo: Character lf) ]);
				yourself ].
	Error signal: 'failed to retrieve oci error code and description'
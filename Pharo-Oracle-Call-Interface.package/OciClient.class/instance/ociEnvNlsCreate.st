private oci calls
ociEnvNlsCreate
	| externalAddr returnValue |
	externalAddr := ExternalAddress new.
	returnValue := Oci
		OCIEnvNlsCreate: externalAddr
		mode: OCI_DEFAULT
		ctxp: nil
		malocfp: 0
		ralocfp: 0
		mfreefp: 0
		xtramemsz: 0
		usrmempp: ExternalAddress null
		charset: self oracleEncodingId
		ncharset: self oracleUnicodeEncodingId.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ externalAddr ].
	self signalErrorWith: [ :ws | ws << 'OCIEnvNlsCreate failed. (errCode: ' << returnValue << ')' ]
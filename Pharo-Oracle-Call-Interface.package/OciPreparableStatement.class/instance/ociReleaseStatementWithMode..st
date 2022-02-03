oci
ociReleaseStatementWithMode: mode
	| returnValue |
	returnValue := Oci
		OCIStmtRelease: statementHandle
		errhp: self client errorHandle
		key: self keyBytes
		keylen: self keySize
		mode: mode.
	returnValue == OCI_SUCCESS
		ifTrue: [ statementHandle := nil.
			^ self ].
	self client handleErrorsWithReturnValue: returnValue
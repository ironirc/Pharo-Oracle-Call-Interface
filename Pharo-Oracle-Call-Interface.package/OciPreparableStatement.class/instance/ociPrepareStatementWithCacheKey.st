oci
ociPrepareStatementWithCacheKey
	| returnValue |
	statementHandle := ExternalAddress new.
	returnValue := Oci
		OCIStmtPrepare2: self client serviceContextHandle
		stmthp: statementHandle
		errhp: self client errorHandle
		stmttext: nil
		stmt_len: 0
		key: self keyBytes
		keylen: self keySize
		language: OCI_NTV_SYNTAX
		mode: OCI_DEFAULT.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ self ].
	self client handleErrorsWithReturnValue: returnValue
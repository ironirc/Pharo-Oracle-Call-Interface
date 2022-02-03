oci
ociPrepareStatementWithStatementString
	| sqlBytes returnValue |
	sqlBytes := self statementString nullTerminatedEncodeWith: #utf8.
	statementHandle := ExternalAddress new.
	returnValue := Oci
		OCIStmtPrepare2: self client serviceContextHandle
		stmthp: statementHandle
		errhp: self client errorHandle
		stmttext: sqlBytes
		stmt_len: sqlBytes size
		key: nil
		keylen: 0
		language: OCI_NTV_SYNTAX
		mode: OCI_DEFAULT.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ self ].
	self client handleErrorsWithReturnValue: returnValue
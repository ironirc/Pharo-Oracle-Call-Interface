oci
ociExecuteStatement
	| rv |
	rv := Oci
		OCIStmtExecute: self client serviceContextHandle
		stmtp: statementHandle
		errhp: self client errorHandle
		iters: self executeStatementIterations
		rowoff: 0
		snap_in: nil
		snap_out: nil
		mode: OCI_DEFAULT.
	rv == OCI_SUCCESS
		ifTrue: [ ^ self ].
	self client handleErrorsWithReturnValue: rv
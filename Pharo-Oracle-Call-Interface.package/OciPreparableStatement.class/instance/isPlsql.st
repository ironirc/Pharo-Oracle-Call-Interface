test
isPlsql
	^ {OCI_STMT_BEGIN.
	OCI_STMT_DECLARE} includes: self ociAttributeGetStatementType
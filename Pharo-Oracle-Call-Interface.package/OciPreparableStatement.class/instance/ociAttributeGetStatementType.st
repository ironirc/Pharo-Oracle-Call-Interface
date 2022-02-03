oci
ociAttributeGetStatementType
	^ self client ociAttributeGetInteger: OCI_ATTR_STMT_TYPE descriptor: statementHandle type: OCI_HTYPE_STMT
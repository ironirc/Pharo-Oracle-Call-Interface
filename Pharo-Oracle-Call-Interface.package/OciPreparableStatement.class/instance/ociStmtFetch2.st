oci
ociStmtFetch2
	| returnValue rowCount fetchedRows |
	returnValue := Oci
		OCIStmtFetch2: statementHandle
		errhp: self client errorHandle
		nrows: blockFactor
		orientation: OCI_FETCH_NEXT
		fetchOffset: 1
		mode: OCI_DEFAULT.
	"OCI_ATTR_ROW_COUNT contains the highest absolute row value that was fetched."
	rowCount := self client ociAttributeGetInteger: OCI_ATTR_ROW_COUNT descriptor: statementHandle type: OCI_HTYPE_STMT.
	fetchedRows := self client ociAttributeGetInteger: OCI_ATTR_ROWS_FETCHED descriptor: statementHandle type: OCI_HTYPE_STMT.
	self rowsInBlock: fetchedRows.
	self totalRows: rowCount.
	fetchedRows < blockFactor
		ifTrue: [ ^ fetchedRows ].
	({OCI_NO_DATA.
	OCI_SUCCESS.
	OCI_SUCCESS_WITH_INFO} includes: returnValue)
		ifFalse: [ self client handleErrorsWithReturnValue: returnValue ].
	^ fetchedRows
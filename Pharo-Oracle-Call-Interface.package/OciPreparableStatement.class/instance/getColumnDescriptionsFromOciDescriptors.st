public
getColumnDescriptionsFromOciDescriptors
	^ Array
		streamContents: [ :colDescrStream | 
			self
				doWithColumnDescriptorsOfCurrentStatement: [ :colIndex :colDescPointer | 
					| colDescr internalSize internalType |
					(colDescr := OciColumnDescription new)
						session: self client;
						position: colIndex;
						name: (self client ociAttributeGetString: OCI_ATTR_NAME descriptor: colDescPointer type: OCI_DTYPE_PARAM);
						maxNumberOfBytes: (internalSize := self client ociAttributeGetInteger: OCI_ATTR_DATA_SIZE descriptor: colDescPointer type: OCI_DTYPE_PARAM);
						internalType: (internalType := self client ociAttributeGetInteger: OCI_ATTR_DATA_TYPE descriptor: colDescPointer type: OCI_DTYPE_PARAM);
						type: (self client class ociTypeToSmalltalkTypeMapping at: internalType);
						precision: (self client ociAttributeGetInteger: OCI_ATTR_PRECISION descriptor: colDescPointer type: OCI_DTYPE_PARAM);
						scale: (self client ociAttributeGetInteger: OCI_ATTR_SCALE descriptor: colDescPointer type: OCI_DTYPE_PARAM);
						isNullable: (self client ociAttributeGetBoolean: OCI_ATTR_IS_NULL descriptor: colDescPointer type: OCI_DTYPE_PARAM);
						isUnicodeColumn: (self client ociAttributeGetInteger: OCI_ATTR_CHARSET_FORM descriptor: colDescPointer type: OCI_DTYPE_PARAM) == SQLCS_NCHAR.
					colDescrStream nextPut: colDescr ] ]
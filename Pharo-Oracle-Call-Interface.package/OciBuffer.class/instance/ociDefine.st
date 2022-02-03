private
ociDefine
	| rv |
	rv := Oci
		OCIDefineByPos: self preparableStatement  statementHandle
		defnpp: self defineHandle
		errhp: self preparableStatement errorHandle
		position: position
		valuep: baseAddressOfBufferArray
		value_sz: singleBufferSize
		dty: externalType
		indp: baseAddressOfIndicators
		rlenp: baseAddressOfLengthsArray
		rcodep: baseAddressOfReturnCodes
		mode: OCI_DEFAULT.
	rv == OCI_SUCCESS
		ifTrue: [ ^ self ].
	self handleErrorsWithReturnValue: rv
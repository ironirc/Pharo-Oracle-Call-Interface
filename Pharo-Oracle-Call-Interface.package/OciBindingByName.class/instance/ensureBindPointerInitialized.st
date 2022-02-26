private
ensureBindPointerInitialized

	| bindName returnValue |
	bindName := self name utf8Encoded.
	returnValue := Oci
		               OCIBindByName: self statement statementHandle
		               bindpp: bindPointer
		               errhp: self statement client errorHandle
		               placeholder: bindName
		               placeh_len: bindName size
		               valuep: buffer baseAddressOfBufferArray
		               value_sz: buffer singleBufferSize
		               dty: buffer class externalDatabaseType
		               indp: nil
		               alenp: nil
		               rcodep: nil
		               maxarr_len: 0
		               curelep: nil
		               mode: OCI_DEFAULT.
	returnValue == OCI_SUCCESS ifTrue: [ ^ self ].
	self statement client handleErrorsWithReturnValue: returnValue
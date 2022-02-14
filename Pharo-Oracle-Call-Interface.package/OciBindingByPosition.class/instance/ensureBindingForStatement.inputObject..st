private
ensureBindingForStatement: aStatement inputObject: anObject

	| returnValue val buff |
	val := self getValueFrom: anObject.
	buff := val  ociBufferClass new.
	buff preparableStatement: aStatement.
	buff setSingleBufferSizeForValue: val.
	buff allocateExternalMemory. "how to determine much memory do we need?"
	buff value: val toBufferAtRow: 1. "external memory has to be ready"
	returnValue := Oci
		               OCIBindByPos: aStatement statementHandle
		               bindpp: bindPointer
		               errhp: aStatement client errorHandle
		               position: position
		               valuep: buff baseAddressOfBufferArray
		               value_sz: buff singleBufferSize
		               dty: buff class externalDatabaseType
		               indp: nil
		               alenp: nil
		               rcodep: nil
		               maxarr_len: 0 "first trying to make it work..."
		               curelep: nil
		               mode: OCI_DEFAULT. 
	returnValue == OCI_SUCCESS ifTrue: [ ^ self ].
	aStatement client handleErrorsWithReturnValue: returnValue
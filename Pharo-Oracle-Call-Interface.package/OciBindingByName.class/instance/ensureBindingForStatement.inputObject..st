printing
ensureBindingForStatement: aStatement inputObject: anObject
	| bindName returnValue val buff |
	bindName := self name utf8Encoded.
	val := self getValueFrom: anObject.
	buff := val ociBufferClass new.
	buff preparableStatement: aStatement .
	buff setSingleBufferSizeForValue: val. 
	buff allocateExternalMemory.  "how to determine much memory do we need?"
	buff value: val toBufferAtRow: 1. "external memory has to be ready"
	returnValue := Oci
		OCIBindByName: aStatement statementHandle
		bindpp: bindPointer
		errhp: aStatement client errorHandle
		placeholder: bindName
		placeh_len: bindName size
		valuep: buff baseAddressOfBufferArray
		value_sz: buff singleBufferSize
		dty: buff class externalDatabaseType
		indp: nil
		alenp: nil
		rcodep: nil
		maxarr_len: nil
		curelep: nil
		mode: OCI_DEFAULT.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ self ].
	aStatement client handleErrorsWithReturnValue: returnValue
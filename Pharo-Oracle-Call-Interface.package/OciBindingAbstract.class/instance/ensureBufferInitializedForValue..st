private
ensureBufferInitializedForValue: val

	buffer ifNil: [ 
		| buff |
		buff := val ociBufferClass new.
		buff preparableStatement: self statement.
		buff setSingleBufferSizeForValue: val.
		buff allocateExternalMemoryForBlockFactor: 1.
		buffer := buff ]
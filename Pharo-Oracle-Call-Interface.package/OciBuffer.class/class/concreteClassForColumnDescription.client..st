private
concreteClassForColumnDescription: cd client: aClient
	"cd isLargeObject
		ifTrue: [ ^ OciBufferLargeObject ].
	cd isCursor
		ifTrue: [ ^ OciBufferRefCursor ]."
"TODO
	intlType == INTERNAL_DATATYPE_BINARY_FLOAT
		ifTrue: [ extlType := SQLT_BFLOAT.
			elemSize := 4 ].
	intlType == INTERNAL_DATATYPE_BINARY_DOUBLE
		ifTrue: [ extlType := SQLT_BDOUBLE.
			elemSize := 8 ].
	
	(intlType == SQLT_RID or: [ intlType == SQLT_RDD ])
		ifTrue: [ ROWID can be as much as 256 bytes in string form.
			extlType := SQLT_CHR.
			elemSize := 256 ]."


	(cd internalType == SQLT_TIMESTAMP or: [ cd internalType == SQLT_TIMESTAMP_TZ ])
		ifTrue: [ "self halt." "probably a different kind of buffer needed?"
			^ OciBufferDate ].
		
	cd internalType == SQLT_DAT
		ifTrue: [ ^ OciBufferDate ].
	cd internalType == INTERNAL_DATATYPE_VARCHAR2
		ifTrue: [ cd maxNumberOfBytes > aClient  maxVarcharStringSize
				ifTrue: [ ^ OciBufferLong ]
				ifFalse: [ ^ OciBufferVarchar2 ] ].
	cd internalType == INTERNAL_DATATYPE_CHAR
		ifTrue: [ ^ OciBufferChar ]. 
	cd internalType == INTERNAL_DATATYPE_LONG
		ifTrue: [ ^ OciBufferLong ].
	cd internalType == INTERNAL_DATATYPE_RAW
		ifTrue: [ cd maxNumberOfBytes > aClient maxVarcharStringSize
				ifTrue: [ ^ OciBufferLongRaw ]
				ifFalse: [ ^ OciBufferRaw ] ].
	cd internalType == INTERNAL_DATATYPE_NUMBER
		ifTrue: [ (cd scale == -127 and: [ cd precision ~= 0 ])
				ifTrue: [ cd precision <= 26
						ifTrue: [ ^ OciBufferFloat ].
					cd precision <= 46
						ifTrue: [ ^ OciBufferFloatDouble ] ] ].
	cd isScaledDecimal
		ifTrue: [ ^ OciBufferScaledDecimal ].
	cd isInteger
		ifTrue: [ ^ OciBufferInteger ].
	self error: 'unable to determine the concrete oci buffer class'
accessing
valueAtRow: rowIndex
	baseAddressOfReturnCodes
		ifNotNil: [ | returnCode |
			returnCode := baseAddressOfReturnCodes unsignedShortAt: (rowIndex - 1) * 2 + 1.
			returnCode == OCI_RTN_CODE_NULL_DATA
				ifTrue: [ ^ nil ].
			(returnCode == OCI_SUCCESS or: [ returnCode == OCI_RTN_CODE_TRUNCATED_DATA ])
				ifFalse: [ self
						error:
							'oci error at rownum: ' , rowIndex displayString , ' for column: ' , self columnDescription name , ' error code: '
								, returnCode displayString ] ].
	^ self valueFromBufferAtRow: rowIndex
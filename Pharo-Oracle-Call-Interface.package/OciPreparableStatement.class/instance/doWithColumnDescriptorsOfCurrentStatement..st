public
doWithColumnDescriptorsOfCurrentStatement: aBlock
	| probedColIdx colDescrPointer |
	probedColIdx := 0.
	[ probedColIdx := probedColIdx + 1.
	colDescrPointer := self client ociParamGet: statementHandle type: OCI_HTYPE_STMT startingAt: probedColIdx.
	colDescrPointer notNil ]
		whileTrue: [ [ aBlock value: probedColIdx value: colDescrPointer ]
				ensure: [ Oci OCIDescriptorFree: colDescrPointer type: OCI_DTYPE_PARAM ] ]
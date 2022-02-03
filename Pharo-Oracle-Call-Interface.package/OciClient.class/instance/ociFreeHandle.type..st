oci calls
ociFreeHandle: aHandle type: aType
	aHandle ifNil: [ ^self ].
	aHandle isNull ifTrue: [ ^self ].
	Oci OCIHandleFree: aHandle type: aType
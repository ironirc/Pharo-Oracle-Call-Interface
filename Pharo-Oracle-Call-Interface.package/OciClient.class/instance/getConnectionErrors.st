error handling
getConnectionErrors
	| errors err errorIndex |
	errors := OrderedCollection new.
	errorIndex := 1.
	[ (err := self ociErrorGet: self errorHandle type: OCI_HTYPE_ERROR at: errorIndex) notNil ]
		whileTrue: [ errors add: err.
			errorIndex := errorIndex + 1 ].
	^ errors
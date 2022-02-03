accessing derived
encoding
	encoding
		ifNil: [ encoding := self class getEncodingFromNlsLangEnvironmentVariable
				ifNil: [ self getEncodingFromOci ] ].
	^ encoding
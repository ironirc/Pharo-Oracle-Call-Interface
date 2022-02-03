public
getEncodingFromNlsLangEnvironmentVariable
"
self getEncodingFromNlsLangEnvironmentVariable
"
	| envString envStringFragment |
	envString := OSEnvironment current at: 'NLS_LANG' ifAbsent: [ '' ].
	envStringFragment := envString
		copyFrom: (envString indexOf: $.) + 1
		to: envString size.
	(envStringFragment isEmpty or: [ envStringFragment = 'NA' ])
		ifTrue: [ ^ #default ].
	^ self encodingMapping
		at: envStringFragment
		ifAbsent: [ self error: 'Unknown column encoding' ]
tests
testGetOracleVersion
	| rows banner |
	rows := client query: 'SELECT banner_full FROM v$version'.
	banner := rows first first.
	self assert: (banner includesSubstring: 'Oracle').
	self assert: client isConnected
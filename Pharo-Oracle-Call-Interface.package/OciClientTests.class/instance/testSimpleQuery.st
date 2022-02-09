tests
testSimpleQuery
	| rows |
	rows := client query: 'SELECT * FROM hobby'.
	self assert: rows first equals: #( 'koken' )
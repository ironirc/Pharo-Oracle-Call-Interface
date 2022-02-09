tests
testSimple
	| statement rows |
	statement := client prepare: 'SELECT * FROM hobby'.
	statement	
		doWhilePrepared: [ rows := statement executeAndReturnRowsWithInput: nil ]
		shouldCache: false.
	self assert: rows first equals: #( 'koken' )
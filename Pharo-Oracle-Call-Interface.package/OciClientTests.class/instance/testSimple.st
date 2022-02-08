tests
testSimple
	| statement rows |
	statement := client newPreparableStatementFor: 'SELECT * FROM hobby'.
	statement	
		doWhilePrepared: [ rows := statement executeAndReturnRowsWithInput: nil ]
		shouldCache: false.
	self assert: rows first equals: #( 'koken' )
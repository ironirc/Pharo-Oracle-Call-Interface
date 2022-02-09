public
query: sqlStatementString
	"Run a one shot SQL query in sqlStatementString and return the resulting rows"
	
	| statement rows |
	statement := self prepare: sqlStatementString.
	rows := nil.
	statement 
 		doWhilePrepared: [ rows := statement executeAndReturnRowsWithInput: nil ]
 		shouldCache: false.
	^ rows
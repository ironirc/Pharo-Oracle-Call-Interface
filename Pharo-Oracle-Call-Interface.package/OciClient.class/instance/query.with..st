public
query: sqlStatementString with: inputObject

	"Run a one shot SQL query in sqlStatementString and return the resulting rows"

	| statement |
	statement := self statementForSql: sqlStatementString.
	^ statement prepareAndExecuteWith: inputObject
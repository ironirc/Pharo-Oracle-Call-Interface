public
query: sqlStatementString

	"Run a one shot SQL query in sqlStatementString and return the resulting rows"

	^ self query: sqlStatementString with: nil
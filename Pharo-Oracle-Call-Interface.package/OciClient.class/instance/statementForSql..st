public
statementForSql: sqlStatementString
	"Prepare sqlStatementString returning an instance of OciPreparedStatement.
	A generated name will be used"
	
	^ self statementForSql: sqlStatementString named: sqlStatementString hash asString
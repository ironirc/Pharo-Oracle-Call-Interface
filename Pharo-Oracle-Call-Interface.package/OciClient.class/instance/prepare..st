public
prepare: sqlStatementString
	"Prepare sqlStatementString returning an instance of OciPreparedStatement.
	A generated name will be used"
	
	^ self prepare: sqlStatementString named: sqlStatementString hash asString
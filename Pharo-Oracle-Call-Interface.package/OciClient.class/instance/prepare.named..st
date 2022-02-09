public
prepare: sqlStatementString named: statementName
	"Create and return an instance of OciPreparedStatement.
	statementName must be unique"

	| statement |
	self ensureConnected.
	statement := OciPreparableStatement new.
	statement client: self.
	statement name: statementName.
	statement setStatementString: sqlStatementString.
	^ statement
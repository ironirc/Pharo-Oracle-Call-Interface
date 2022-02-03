private
setStatementString: aString
	(self class formattedStatementAndBindingsForStatementString: aString)
		ifNotNil: [ :assoc | 
			self statementString: assoc key.
			self bindings: assoc value ]
oci calls
newPreparableStatementFor: aStatementString
	^ self newPreparableStatementFor: aStatementString named: aStatementString hash asString
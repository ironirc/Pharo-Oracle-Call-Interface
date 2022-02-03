instance creation
newForColumnDescription: cd preparableStatement: aPreparableStatement
	| buffer |
	buffer := (self concreteClassForColumnDescription: cd client: aPreparableStatement client) new.
	buffer
		preparableStatement: aPreparableStatement;
		initializeWithColumnDescription: cd.
	^ buffer
public
executeAndReturnRowsWithInput: anObject
	self ensureInputBindingsForInputObject: anObject.
	self ociExecuteStatement.
	self initializeColumnDescriptionsForCurrentStatement.
	self columnDescriptions
		ifNotNil: [ | rowsFetched rows |
			self initializeOciBuffers.
			rows := OrderedCollection new.
			[ rowsFetched := self ociStmtFetch2.
			1 to: rowsFetched do: [ :rowIndex | rows add: (self rowValueArrayForRow: rowIndex) ].
			rowsFetched isZero ] whileFalse.
			^ rows ].
	self error: 'no column descriptions retrieved after ociExecuteStatement'
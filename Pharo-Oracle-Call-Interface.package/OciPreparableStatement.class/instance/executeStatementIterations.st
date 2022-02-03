private
executeStatementIterations
	self flag: 'refine'.
	self isSelect
		ifTrue: [ ^ 0 ].

	" (self bindValuePointersHolder value isNil or: [ self isPlsql  ])
				ifTrue: [ 1 ]
				ifFalse: [ self maxBindSize ] "
	^ self error: 'not yet fully implemented'
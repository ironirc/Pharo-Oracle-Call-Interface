public
ensureInputBindingsForInputObject: anObject
	self bindings do: [ :each | each ensureBindingForStatement: self inputObject: anObject ].
	
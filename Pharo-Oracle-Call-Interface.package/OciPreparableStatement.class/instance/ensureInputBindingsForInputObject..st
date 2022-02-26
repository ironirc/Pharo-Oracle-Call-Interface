public
ensureInputBindingsForInputObject: anObject
	self bindings do: [ :each | each ensureBindingForInputObject: anObject ].
	
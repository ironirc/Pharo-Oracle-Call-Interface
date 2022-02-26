private
ensureBindingForInputObject: anObject

	| val |
	val := self getValueFromInput: anObject.
	self ensureBufferInitializedForValue: val.
	self ensureBindPointerInitialized.
	buffer value: val toBufferAtRow: 1
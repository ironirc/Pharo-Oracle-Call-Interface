initialization
setSingleBufferSizeForValue: aValue
	self flag: 'revise'.
	"We could use aValue's size to set the buffer size. But when this buffer gets reused for a larger value, this gives problems.
	Also take a look at OciBufferVarchar2 class>>#externalDatabaseType "
	singleBufferSize := "(self encodeStringAsByteArray: aValue) size" 4000
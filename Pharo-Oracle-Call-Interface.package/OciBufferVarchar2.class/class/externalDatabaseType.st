constants
externalDatabaseType
	self flag: 'revise'.
	"previously used SQLT_CHR = VARCHAR2, which might be correct"
	"also see OciBufferVarchar2>>#setSingleBufferSizeForValue:"
	^SQLT_STR "Null-Terminated string"
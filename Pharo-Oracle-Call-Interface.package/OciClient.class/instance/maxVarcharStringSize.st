accessing derived
maxVarcharStringSize
	"https://docs.oracle.com/database/121/REFRN/GUID-D424D23B-0933-425F-BC69-9C0E6724693C.htm#REFRN10321"
	^ self isMaxStringSizeExtended
		ifFalse: [ 4000 ]
		ifTrue: [ 32767 ]
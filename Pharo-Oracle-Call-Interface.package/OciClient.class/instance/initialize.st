initialize-release
initialize
	super initialize.
	parameterPointer := ExternalAddress new.
	self oracleEncodingId: 0.	"871"
	self oracleUnicodeEncodingId: 0.	"871"
	self isMaxStringSizeExtended: false.	"https://docs.oracle.com/database/121/REFRN/GUID-D424D23B-0933-425F-BC69-9C0E6724693C.htm#REFRN10321"
	self useCredentialsUsernamePassword.
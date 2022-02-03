ffi-calls
OCIStmtRelease: stmthp errhp: errhp key: key keylen: keylen mode: mode
	"sword OCIStmtRelease ( OCIStmt *stmthp,
 OCIError *errhp,
 const OraText *key,
 ub4 keylen,
 ub4 mode );"

	^ self ffiCall: #(sword OCIStmtRelease #(void * stmthp , void * errhp , void * key , ub4 keylen , ub4 mode))
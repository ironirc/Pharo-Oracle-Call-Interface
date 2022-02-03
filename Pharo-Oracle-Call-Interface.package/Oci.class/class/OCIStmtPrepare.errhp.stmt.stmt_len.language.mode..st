ffi-calls
OCIStmtPrepare: stmtp errhp: errhp stmt: stmt stmt_len: stmt_len language: language mode: mode
	"sword OCIStmtPrepare ( 
 OCIStmt *stmtp,
 OCIError *errhp,
 const OraText *stmt,
 ub4 stmt_len,
 ub4 language,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCIStmtPrepare #(void * stmtp , void * errhp , void * stmt , ub4 stmt_len , ub4 language , ub4 mode))
			
	
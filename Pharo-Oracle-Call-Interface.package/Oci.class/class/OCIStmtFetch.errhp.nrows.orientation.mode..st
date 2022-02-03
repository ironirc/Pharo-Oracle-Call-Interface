ffi-calls
OCIStmtFetch: stmtp errhp: errhp nrows: nrows orientation: orientation mode: mode
	"sword OCIStmtFetch ( OCIStmt *stmtp,
 OCIError *errhp,
 ub4 nrows,
 ub2 orientation,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCIStmtFetch #(void * stmtp , void * errhp , ub4 nrows , ub2 orientation , ub4 mode))
ffi-calls
OCIStmtFetch2: stmthp errhp: errhp nrows: nrows orientation: orientation fetchOffset: fetchOffset mode: mode
	"sword OCIStmtFetch2 ( OCIStmt *stmthp,
 OCIError *errhp,
 ub4 nrows,
 ub2 orientation,
 sb4 fetchOffset,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCIStmtFetch2 #(void * stmthp , void * errhp , ub4 nrows , ub2 orientation , sb4 fetchOffset , ub4 mode))
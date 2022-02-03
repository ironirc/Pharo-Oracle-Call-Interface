ffi-calls
OCIStmtExecute: svchp stmtp: stmtp errhp: errhp iters: iters rowoff: rowoff snap_in: snap_in snap_out: snap_out mode: mode
	"sword OCIStmtExecute ( OCISvcCtx *svchp,
 OCIStmt *stmtp,
 OCIError *errhp,
 ub4 iters,
 ub4 rowoff,
 const OCISnapshot *snap_in,
 OCISnapshot *snap_out,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCIStmtExecute #(void * svchp , void * stmtp , void * errhp , ub4 iters , ub4 rowoff , NULL , NULL , ub4 mode))
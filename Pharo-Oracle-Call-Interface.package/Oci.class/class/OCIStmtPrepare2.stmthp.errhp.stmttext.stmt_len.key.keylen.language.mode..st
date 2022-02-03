ffi-calls
OCIStmtPrepare2: svchp stmthp: stmthp errhp: errhp stmttext: stmttext stmt_len: stmt_len key: key keylen: keylen language: language mode: mode
	"sword OCIStmtPrepare2 ( OCISvcCtx *svchp,
 OCIStmt **stmthp,
 OCIError *errhp,
 const OraText *stmttext,
 ub4 stmt_len,
 const OraText *key,
 ub4 keylen,
 ub4 language,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCIStmtPrepare2 #(void * svchp , void ** stmthp , void * errhp , void * stmttext , ub4 stmt_len , void * key , ub4 keylen , ub4 language , ub4 mode))
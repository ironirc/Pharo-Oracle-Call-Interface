ffi-calls
OCIDefineByPos: stmtp defnpp: defnpp errhp: errhp position: position valuep: valuep value_sz: value_sz dty: dty indp: indp rlenp: rlenp rcodep: rcodep mode: mode
	"sword OCIDefineByPos ( OCIStmt *stmtp,
 OCIDefine **defnpp,
 OCIError *errhp,
 ub4 position,
 void *valuep,
 sb4 value_sz,
 ub2 dty,
 void *indp,
 ub2 *rlenp,
 ub2 *rcodep,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCIDefineByPos #(void * stmtp , void ** defnpp , void * errhp , ub4 position , void * valuep , sb4 value_sz , ub2 dty , void * indp , ub2 * rlenp , ub2 * rcodep , ub4 mode))
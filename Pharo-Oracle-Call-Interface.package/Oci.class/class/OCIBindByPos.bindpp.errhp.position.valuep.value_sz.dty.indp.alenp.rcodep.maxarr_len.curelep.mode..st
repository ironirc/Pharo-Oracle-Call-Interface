ffi-calls
OCIBindByPos: stmtp bindpp: bindpp errhp: errhp position: position valuep: valuep value_sz: value_sz dty: dty indp: indp alenp: alenp rcodep: rcodep maxarr_len: maxarr_len curelep: curelep mode: mode
	"https://docs.oracle.com/cd/E11882_01/appdev.112/e10646.pdf"

	"sword OCIBindByPos ( OCIStmt *stmtp,
 OCIBind **bindpp,
 OCIError *errhp,
 ub4 position,
 void *valuep,
 sb4 value_sz,
 ub2 dty,
 void *indp,
 ub2 *alenp,
 ub2 *rcodep,
 ub4 maxarr_len,
 ub4 *curelep,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCIBindByPos #(void * stmtp , void ** bindpp , void * errhp , ub4 position , void * valuep , sb4 value_sz , ub2 dty , void * indp , ub2 * alenp , ub2 * rcodep , ub4 maxarr_len , ub4 * curelep , ub4 mode))
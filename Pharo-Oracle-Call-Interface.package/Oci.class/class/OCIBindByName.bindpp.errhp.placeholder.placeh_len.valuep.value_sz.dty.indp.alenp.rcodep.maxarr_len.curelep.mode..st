ffi-calls
OCIBindByName: stmtp bindpp: bindpp errhp: errhp placeholder: placeholder placeh_len: placeh_len valuep: valuep value_sz: value_sz dty: dty indp: indp alenp: alenp rcodep: rcodep maxarr_len: maxarr_len curelep: curelep mode: mode
	"https://docs.oracle.com/cd/E11882_01/appdev.112/e10646.pdf"

	"sword OCIBindByName ( OCIStmt *stmtp,
 OCIBind **bindpp,
 OCIError *errhp,
 const OraText *placeholder,
 sb4 placeh_len,
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
			#(sword OCIBindByName #(void * stmtp , void ** bindpp , void * errhp , void * placeholder , sb4 placeh_len , void * valuep , sb4 value_sz , ub2 dty , void * indp , ub2 * alenp , ub2 * rcodep , ub4 maxarr_len , ub4 * curelep , ub4 mode))
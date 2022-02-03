ffi-calls
OCIErrorGet: hndlp recordno: recordno sqlstate: sqlstate errcodep: errcodep bufp: bufp bufsiz: bufsiz type: type
	"sword OCIErrorGet ( void *hndlp,
 ub4 recordno,
 OraText *sqlstate,
 sb4 *errcodep,
 OraText *bufp,
 ub4 bufsiz,
 ub4 type );"

	^ self
		ffiCall:
			#(sword OCIErrorGet #(void * hndlp , ub4 recordno , NULL , sb4 * errcodep , void * bufp , ub4 bufsiz , ub4 type))
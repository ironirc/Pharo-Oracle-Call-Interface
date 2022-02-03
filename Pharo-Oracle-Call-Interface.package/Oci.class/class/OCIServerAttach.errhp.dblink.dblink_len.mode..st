ffi-calls
OCIServerAttach: srvhp errhp: errhp dblink: dblink dblink_len: dblink_len mode: mode
	"sword OCIServerAttach ( OCIServer *srvhp,
 OCIError *errhp,
 const OraText *dblink,
 sb4 dblink_len,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCIServerAttach #(void * srvhp , void * errhp , void * dblink , sb4 dblink_len , ub4 mode))
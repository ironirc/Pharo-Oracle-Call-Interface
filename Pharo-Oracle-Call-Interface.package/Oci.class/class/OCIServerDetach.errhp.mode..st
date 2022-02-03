ffi-calls
OCIServerDetach: srvhp errhp: errhp mode: mode

	"sword OCIServerDetach ( OCIServer *srvhp,
 OCIError *errhp,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCIServerDetach #(void * srvhp , void * errhp , ub4 mode))
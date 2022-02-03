ffi-calls
OCISessionEnd: svchp errhp: errhp usrhp: usrhp mode: mode
	"sword OCISessionEnd ( OCISvcCtx *svchp,
 OCIError *errhp,
 OCISession *usrhp,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCISessionEnd #(void * svchp , void * errhp , void * usrhp , ub4 mode))
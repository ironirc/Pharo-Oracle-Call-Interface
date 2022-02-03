ffi-calls
OCISessionBegin: svchp errhp: errhp usrhp: usrhp credt: credt mode: mode
	"sword OCISessionBegin ( OCISvcCtx *svchp,
 OCIError *errhp,
 OCISession *usrhp,
 ub4 credt,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCISessionBegin #(void * svchp , void * errhp , void * usrhp , ub4 credt , ub4 mode))
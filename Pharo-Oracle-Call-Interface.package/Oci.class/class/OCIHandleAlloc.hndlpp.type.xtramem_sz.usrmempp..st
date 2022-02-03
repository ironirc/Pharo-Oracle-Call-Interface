ffi-calls
OCIHandleAlloc: parenth hndlpp: hndlpp type: type xtramem_sz: xtramem_sz usrmempp: usrmempp
"
sword OCIHandleAlloc ( const void *parenth,
 void **hndlpp,
 ub4 type,
 size_t xtramem_sz,
 void **usrmempp );
"

	^ self
		ffiCall:
			#(short OCIHandleAlloc #(const void * parenth , void ** hndlpp , ub4 type , size_t xtramem_sz , NULL))
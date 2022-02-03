ffi-calls
OCIHandleFree: hndlpp type: type
	"
sword OCIHandleFree ( void *hndlp,
 ub4 type );
"

	^ self ffiCall: #(short OCIHandleFree #(void ** hndlpp , ub4 type))
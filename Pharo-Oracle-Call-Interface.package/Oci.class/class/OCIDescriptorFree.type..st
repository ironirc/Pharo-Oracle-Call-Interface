ffi-calls
OCIDescriptorFree: descp type: type
	"sword OCIDescriptorFree ( void *descp,
 ub4 type );"

	^ self ffiCall: #(sword OCIDescriptorFree #(void * descp , ub4 type))
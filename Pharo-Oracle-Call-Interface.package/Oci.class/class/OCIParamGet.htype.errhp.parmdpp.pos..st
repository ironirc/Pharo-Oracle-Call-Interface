ffi-calls
OCIParamGet: hndlp htype: htype errhp: errhp parmdpp: parmdpp pos: pos
	"
sword OCIParamGet ( const void *hndlp,
 ub4 htype,
 OCIError *errhp,
 void **parmdpp,
 ub4 pos );
"

	^ self
		ffiCall:
			#(sword OCIParamGet #(const void * hndlp , ub4 htype , void * errhp , void ** parmdpp , ub4 pos))
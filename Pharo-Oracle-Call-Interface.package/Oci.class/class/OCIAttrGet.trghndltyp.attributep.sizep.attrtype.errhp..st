ffi-calls
OCIAttrGet: trgthndlp trghndltyp: trghndltyp attributep: attributep sizep: sizep attrtype: attrtype errhp: errhp
	"sword OCIAttrGet ( const void *trgthndlp,
 ub4 trghndltyp,
 void *attributep,
 ub4 *sizep,
 ub4 attrtype,
 OCIError *errhp );"

	^ self
		ffiCall:
			#(sword OCIAttrGet #(const void * trgthndlp , ub4 trghndltyp , void * attributep , ub4 * sizep , ub4 attrtype , void * errhp))
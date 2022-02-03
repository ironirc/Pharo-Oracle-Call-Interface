ffi-calls
OCIAttrSet: trgthndlp trghndltyp: trghndltyp attributep: attributep size: size attrtype: attrtype errhp: errhp
	"sword OCIAttrSet ( void *trgthndlp,
 ub4 trghndltyp,
 void *attributep,
 ub4 size,
 ub4 attrtype,
 OCIError *errhp );"

	^ self
		ffiCall:
			#(sword OCIAttrSet #(void * trgthndlp , ub4 trghndltyp , void * attributep , ub4 size , ub4 attrtype , void * errhp))
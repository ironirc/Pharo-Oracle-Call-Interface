ffi-calls
OCIEnvNlsCreate: envhpp mode: mode ctxp: ctxp malocfp: malocfp ralocfp: ralocfp mfreefp: mfreefp xtramemsz: xtramemsz usrmempp: usrmempp charset: charset ncharset: ncharset
	"https://docs.oracle.com/cd/E11882_01/appdev.112/e10646/oci16rel001.htm#LNOCI17114"

	"sword OCIEnvNlsCreate ( OCIEnv **envhpp,
 ub4 mode,
 void *ctxp,
 void *(*malocfp)
 (void *ctxp,
 size_t size),
 void *(*ralocfp)
 (void *ctxp,
 void *memptr,
 size_t newsize),
 void (*mfreefp)
 (void *ctxp,
 void *memptr))
 size_t xtramemsz,
 void **usrmempp
 ub2 charset,
 ub2 ncharset );"

	^ self
		ffiCall:
			#(sword OCIEnvNlsCreate #(void ** #envhpp , ub4 mode , NULL , NULL , NULL , NULL , size_t xtramemsz , NULL , ub2 charset , ub2 ncharset))
ffi-calls
OCIInitialize: mode ctxp: ctxp malocfp: malocfp ralocfp: ralocfp mfreefp: mfreefp
	"Initializes the OCI process environment. This function is deprecated."
	"sword OCIInitialize ( ub4           mode,
                      const void    *ctxp, 
                      const void    *(*malocfp) 
                                    ( void  *ctxp,
                                        size_t size ),
                      const void    *(*ralocfp)
                                    ( void  *ctxp,
                                       void  *memptr,
                                       size_t newsize ),
                      const void    (*mfreefp)
                                    ( void  *ctxp,
                                       void  *memptr ));"

	^ self
		ffiCall:
			#(short OCIInitialize #(byte mode , void *ctxp , int  malocfp , int  ralocfp , int  mfreefp))
	
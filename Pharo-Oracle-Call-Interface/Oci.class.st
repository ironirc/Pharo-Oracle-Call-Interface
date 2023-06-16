Class {
	#name : #Oci,
	#superclass : #Object,
	#pools : [
		'OciConstants',
		'OciConstantsCTypes'
	],
	#category : #'Pharo-Oracle-Call-Interface-UFFI'
}

{ #category : #'ffi-calls' }
Oci class >> OCIAttrGet: trgthndlp trghndltyp: trghndltyp attributep: attributep sizep: sizep attrtype: attrtype errhp: errhp [
	"sword OCIAttrGet ( const void *trgthndlp,
 ub4 trghndltyp,
 void *attributep,
 ub4 *sizep,
 ub4 attrtype,
 OCIError *errhp );"

	^ self
		ffiCall:
			#(sword OCIAttrGet #(const void * trgthndlp , ub4 trghndltyp , void * attributep , ub4 * sizep , ub4 attrtype , void * errhp))
]

{ #category : #'ffi-calls' }
Oci class >> OCIAttrSet: trgthndlp trghndltyp: trghndltyp attributep: attributep size: size attrtype: attrtype errhp: errhp [
	"sword OCIAttrSet ( void *trgthndlp,
 ub4 trghndltyp,
 void *attributep,
 ub4 size,
 ub4 attrtype,
 OCIError *errhp );"

	^ self
		ffiCall:
			#(sword OCIAttrSet #(void * trgthndlp , ub4 trghndltyp , void * attributep , ub4 size , ub4 attrtype , void * errhp))
]

{ #category : #'ffi-calls' }
Oci class >> OCIBindByName: stmtp bindpp: bindpp errhp: errhp placeholder: placeholder placeh_len: placeh_len valuep: valuep value_sz: value_sz dty: dty indp: indp alenp: alenp rcodep: rcodep maxarr_len: maxarr_len curelep: curelep mode: mode [
	"https://docs.oracle.com/cd/E11882_01/appdev.112/e10646.pdf"

	"sword OCIBindByName ( OCIStmt *stmtp,
 OCIBind **bindpp,
 OCIError *errhp,
 const OraText *placeholder,
 sb4 placeh_len,
 void *valuep,
 sb4 value_sz,
 ub2 dty,
 void *indp,
 ub2 *alenp,
 ub2 *rcodep,
 ub4 maxarr_len,
 ub4 *curelep,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCIBindByName #(void * stmtp , void ** bindpp , void * errhp , void * placeholder , sb4 placeh_len , void * valuep , sb4 value_sz , ub2 dty , void * indp , ub2 * alenp , ub2 * rcodep , ub4 maxarr_len , ub4 * curelep , ub4 mode))
]

{ #category : #'ffi-calls' }
Oci class >> OCIBindByPos: stmtp bindpp: bindpp errhp: errhp position: position valuep: valuep value_sz: value_sz dty: dty indp: indp alenp: alenp rcodep: rcodep maxarr_len: maxarr_len curelep: curelep mode: mode [
	"https://docs.oracle.com/cd/E11882_01/appdev.112/e10646.pdf"

	"sword OCIBindByPos ( OCIStmt *stmtp,
 OCIBind **bindpp,
 OCIError *errhp,
 ub4 position,
 void *valuep,
 sb4 value_sz,
 ub2 dty,
 void *indp,
 ub2 *alenp,
 ub2 *rcodep,
 ub4 maxarr_len,
 ub4 *curelep,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCIBindByPos #(void * stmtp , void ** bindpp , void * errhp , ub4 position , void * valuep , sb4 value_sz , ub2 dty , void * indp , ub2 * alenp , ub2 * rcodep , ub4 maxarr_len , ub4 * curelep , ub4 mode))
]

{ #category : #'ffi-calls' }
Oci class >> OCIClientVersion: major_version minor_version: minor_version update_num: update_num patch_num: patch_num port_update_num: port_update_num [
"
void OCIClientVersion ( sword *major_version,
 sword *minor_version,
 sword *update_num,
 sword *patch_num,
 sword *port_update_num );
"

	^ self
		ffiCall:
			#(short OCIClientVersion #(sword * major_version , sword * minor_version , sword * update_num , sword * patch_num , sword * port_update_num))
]

{ #category : #'ffi-calls' }
Oci class >> OCIDefineByPos: stmtp defnpp: defnpp errhp: errhp position: position valuep: valuep value_sz: value_sz dty: dty indp: indp rlenp: rlenp rcodep: rcodep mode: mode [
	"sword OCIDefineByPos ( OCIStmt *stmtp,
 OCIDefine **defnpp,
 OCIError *errhp,
 ub4 position,
 void *valuep,
 sb4 value_sz,
 ub2 dty,
 void *indp,
 ub2 *rlenp,
 ub2 *rcodep,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCIDefineByPos #(void * stmtp , void ** defnpp , void * errhp , ub4 position , void * valuep , sb4 value_sz , ub2 dty , void * indp , ub2 * rlenp , ub2 * rcodep , ub4 mode))
]

{ #category : #'ffi-calls' }
Oci class >> OCIDescriptorFree: descp type: type [
	"sword OCIDescriptorFree ( void *descp,
 ub4 type );"

	^ self ffiCall: #(sword OCIDescriptorFree #(void * descp , ub4 type))
]

{ #category : #'ffi-calls' }
Oci class >> OCIEnvNlsCreate: envhpp mode: mode ctxp: ctxp malocfp: malocfp ralocfp: ralocfp mfreefp: mfreefp xtramemsz: xtramemsz usrmempp: usrmempp charset: charset ncharset: ncharset [
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
]

{ #category : #'ffi-calls' }
Oci class >> OCIErrorGet: hndlp recordno: recordno sqlstate: sqlstate errcodep: errcodep bufp: bufp bufsiz: bufsiz type: type [
	"sword OCIErrorGet ( void *hndlp,
 ub4 recordno,
 OraText *sqlstate,
 sb4 *errcodep,
 OraText *bufp,
 ub4 bufsiz,
 ub4 type );"

	^ self
		ffiCall:
			#(sword OCIErrorGet #(void * hndlp , ub4 recordno , NULL , sb4 * errcodep , void * bufp , ub4 bufsiz , ub4 type))
]

{ #category : #'ffi-calls' }
Oci class >> OCIHandleAlloc: parenth hndlpp: hndlpp type: type xtramem_sz: xtramem_sz usrmempp: usrmempp [
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
]

{ #category : #'ffi-calls' }
Oci class >> OCIHandleFree: hndlpp type: type [
	"
sword OCIHandleFree ( void *hndlp,
 ub4 type );
"

	^ self ffiCall: #(short OCIHandleFree #(void ** hndlpp , ub4 type))
]

{ #category : #'ffi-calls' }
Oci class >> OCIInitialize: mode ctxp: ctxp malocfp: malocfp ralocfp: ralocfp mfreefp: mfreefp [
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
	
]

{ #category : #'ffi-calls' }
Oci class >> OCIParamGet: hndlp htype: htype errhp: errhp parmdpp: parmdpp pos: pos [
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
]

{ #category : #'ffi-calls' }
Oci class >> OCIServerAttach: srvhp errhp: errhp dblink: dblink dblink_len: dblink_len mode: mode [
	"sword OCIServerAttach ( OCIServer *srvhp,
 OCIError *errhp,
 const OraText *dblink,
 sb4 dblink_len,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCIServerAttach #(void * srvhp , void * errhp , void * dblink , sb4 dblink_len , ub4 mode))
]

{ #category : #'ffi-calls' }
Oci class >> OCIServerDetach: srvhp errhp: errhp mode: mode [

	"sword OCIServerDetach ( OCIServer *srvhp,
 OCIError *errhp,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCIServerDetach #(void * srvhp , void * errhp , ub4 mode))
]

{ #category : #'ffi-calls' }
Oci class >> OCISessionBegin: svchp errhp: errhp usrhp: usrhp credt: credt mode: mode [
	"sword OCISessionBegin ( OCISvcCtx *svchp,
 OCIError *errhp,
 OCISession *usrhp,
 ub4 credt,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCISessionBegin #(void * svchp , void * errhp , void * usrhp , ub4 credt , ub4 mode))
]

{ #category : #'ffi-calls' }
Oci class >> OCISessionEnd: svchp errhp: errhp usrhp: usrhp mode: mode [
	"sword OCISessionEnd ( OCISvcCtx *svchp,
 OCIError *errhp,
 OCISession *usrhp,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCISessionEnd #(void * svchp , void * errhp , void * usrhp , ub4 mode))
]

{ #category : #'ffi-calls' }
Oci class >> OCIStmtExecute: svchp stmtp: stmtp errhp: errhp iters: iters rowoff: rowoff snap_in: snap_in snap_out: snap_out mode: mode [
	"sword OCIStmtExecute ( OCISvcCtx *svchp,
 OCIStmt *stmtp,
 OCIError *errhp,
 ub4 iters,
 ub4 rowoff,
 const OCISnapshot *snap_in,
 OCISnapshot *snap_out,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCIStmtExecute #(void * svchp , void * stmtp , void * errhp , ub4 iters , ub4 rowoff , NULL , NULL , ub4 mode))
]

{ #category : #'ffi-calls' }
Oci class >> OCIStmtFetch2: stmthp errhp: errhp nrows: nrows orientation: orientation fetchOffset: fetchOffset mode: mode [
	"sword OCIStmtFetch2 ( OCIStmt *stmthp,
 OCIError *errhp,
 ub4 nrows,
 ub2 orientation,
 sb4 fetchOffset,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCIStmtFetch2 #(void * stmthp , void * errhp , ub4 nrows , ub2 orientation , sb4 fetchOffset , ub4 mode))
]

{ #category : #'ffi-calls' }
Oci class >> OCIStmtFetch: stmtp errhp: errhp nrows: nrows orientation: orientation mode: mode [
	"sword OCIStmtFetch ( OCIStmt *stmtp,
 OCIError *errhp,
 ub4 nrows,
 ub2 orientation,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCIStmtFetch #(void * stmtp , void * errhp , ub4 nrows , ub2 orientation , ub4 mode))
]

{ #category : #'ffi-calls' }
Oci class >> OCIStmtPrepare2: svchp stmthp: stmthp errhp: errhp stmttext: stmttext stmt_len: stmt_len key: key keylen: keylen language: language mode: mode [
	"sword OCIStmtPrepare2 ( OCISvcCtx *svchp,
 OCIStmt **stmthp,
 OCIError *errhp,
 const OraText *stmttext,
 ub4 stmt_len,
 const OraText *key,
 ub4 keylen,
 ub4 language,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCIStmtPrepare2 #(void * svchp , void ** stmthp , void * errhp , void * stmttext , ub4 stmt_len , void * key , ub4 keylen , ub4 language , ub4 mode))
]

{ #category : #'ffi-calls' }
Oci class >> OCIStmtPrepare: stmtp errhp: errhp stmt: stmt stmt_len: stmt_len language: language mode: mode [
	"sword OCIStmtPrepare ( 
 OCIStmt *stmtp,
 OCIError *errhp,
 const OraText *stmt,
 ub4 stmt_len,
 ub4 language,
 ub4 mode );"

	^ self
		ffiCall:
			#(sword OCIStmtPrepare #(void * stmtp , void * errhp , void * stmt , ub4 stmt_len , ub4 language , ub4 mode))
			
	
]

{ #category : #'ffi-calls' }
Oci class >> OCIStmtRelease: stmthp errhp: errhp key: key keylen: keylen mode: mode [
	"sword OCIStmtRelease ( OCIStmt *stmthp,
 OCIError *errhp,
 const OraText *key,
 ub4 keylen,
 ub4 mode );"

	^ self ffiCall: #(sword OCIStmtRelease #(void * stmthp , void * errhp , void * key , ub4 keylen , ub4 mode))
]

{ #category : #'ffi-calls' }
Oci class >> OCITerminate: mode [
	^ self
		ffiCall: #(short OCITerminate #(byte mode))
	
]

{ #category : #'ffi-calls' }
Oci class >> OCITransCommit: svchp errhp: errhp  flags: flags [
	"sword OCITransCommit ( OCISvcCtx *svchp,
 OCIError *errhp,
 ub4 flags );"

	^ self ffiCall:
		  #( sword OCITransCommit #( void * svchp , void * errhp , ub4 flags ) )
]

{ #category : #'ffi-calls' }
Oci class >> OCITransRollback: svchp errhp: errhp flags: flags [
	"sword OCITransRollback ( void *svchp,
 OCIError *errhp,
 ub4 flags );"

	^ self ffiCall:
		  #( sword OCITransRollback #( void * svchp , void * errhp , ub4 flags ) )
]

{ #category : #'ffi-calls' }
Oci class >> OCITransStart: svchp errhp: errhp timeout: timeout flags: flags [
	"sword OCITransStart ( OCISvcCtx *svchp,
 OCIError *errhp,
 uword timeout,
 ub4 flags );"

	^ self ffiCall:
		  #( sword OCITransStart #( void * svchp , void * errhp , uword * timeout , ub4 flags ) )
]

{ #category : #private }
Oci class >> ffiLibrary [
	^ OciFfiLibrary
]

{ #category : #public }
Oci class >> getOracleClientVersionString [
"
self getOracleClientVersionString inspect
"
	| major_version minor_version update_num patch_num port_update_num ma mi |
	major_version := ExternalAddress newPointer autoRelease.
	minor_version := ExternalAddress newPointer autoRelease.
	update_num := ExternalAddress newPointer autoRelease.
	patch_num := ExternalAddress newPointer autoRelease.
	port_update_num := ExternalAddress newPointer autoRelease.
	self
		OCIClientVersion: major_version
		minor_version: minor_version
		update_num: update_num
		patch_num: patch_num
		port_update_num: port_update_num.
	ma := major_version signedShortAt: 1.
	mi := minor_version signedShortAt: 1.
	^ String streamContents: [ :ws | ws << 'Oracle ' << ma printString << 'G release' << mi printString ]
]

{ #category : #public }
Oci class >> ociTerminate [
"
self ociTerminate
"
	| rtval |
	rtval := self OCITerminate: OCI_DEFAULT "only valid value".
	rtval == OCI_SUCCESS
		ifTrue: [ ^ self ].
	self error: 'OCITerminate failed with code: ' , rtval displayString
]

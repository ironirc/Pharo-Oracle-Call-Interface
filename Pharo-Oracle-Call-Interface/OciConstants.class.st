Class {
	#name : #OciConstants,
	#superclass : #Object,
	#classVars : [
		'OCI_ATTR_CHARSET_FORM',
		'OCI_ATTR_DATA_SIZE',
		'OCI_ATTR_DATA_TYPE',
		'OCI_ATTR_IS_NULL',
		'OCI_ATTR_NAME',
		'OCI_ATTR_PASSWORD',
		'OCI_ATTR_PRECISION',
		'OCI_ATTR_ROWS_FETCHED',
		'OCI_ATTR_ROW_COUNT',
		'OCI_ATTR_SCALE',
		'OCI_ATTR_SERVER',
		'OCI_ATTR_SESSION',
		'OCI_ATTR_STMT_TYPE',
		'OCI_ATTR_TRANS',
		'OCI_ATTR_USERNAME',
		'OCI_ATTR_WALL_LOC',
		'OCI_COMMIT_ON_SUCCESS',
		'OCI_CRED_EXT',
		'OCI_CRED_RDBMS',
		'OCI_DEFAULT',
		'OCI_DTYPE_PARAM',
		'OCI_ERROR',
		'OCI_FETCH_NEXT',
		'OCI_HTYPE_DEFINE',
		'OCI_HTYPE_ENV',
		'OCI_HTYPE_ERROR',
		'OCI_HTYPE_SERVER',
		'OCI_HTYPE_SESSION',
		'OCI_HTYPE_STMT',
		'OCI_HTYPE_SVCCTX',
		'OCI_HTYPE_TRANS',
		'OCI_NO_DATA',
		'OCI_NTV_SYNTAX',
		'OCI_RTN_CODE_NULL_DATA',
		'OCI_RTN_CODE_TRUNCATED_DATA',
		'OCI_STMT_BEGIN',
		'OCI_STMT_CACHE',
		'OCI_STMT_DECLARE',
		'OCI_STMT_SELECT',
		'OCI_STRLS_CACHE_DELETE',
		'OCI_SUCCESS',
		'OCI_SUCCESS_WITH_INFO',
		'OCI_THREADED',
		'OCI_TRANS_ISOLMASK',
		'OCI_TRANS_JOIN',
		'OCI_TRANS_LOOSE',
		'OCI_TRANS_NEW',
		'OCI_TRANS_NOMIGRATE',
		'OCI_TRANS_OTHRMASK',
		'OCI_TRANS_OTSRESUME',
		'OCI_TRANS_PROMOTE',
		'OCI_TRANS_READONLY',
		'OCI_TRANS_READWRITE',
		'OCI_TRANS_RESUME',
		'OCI_TRANS_SEPARABLE',
		'OCI_TRANS_SERIALIZABLE',
		'OCI_TRANS_STARTMASK',
		'OCI_TRANS_TIGHT',
		'OCI_TRANS_TYPEMASK',
		'SQLCS_IMPLICIT',
		'SQLCS_NCHAR'
	],
	#category : #'Pharo-Oracle-Call-Interface-Constants'
}

{ #category : #'class initialization' }
OciConstants class >> initialize [
	OCI_SUCCESS := 0.
	OCI_ERROR := -1.
	OCI_DEFAULT := 0.
	OCI_CRED_RDBMS := 1.
	OCI_SUCCESS_WITH_INFO := 1.
	OCI_NTV_SYNTAX := 1.
	OCI_THREADED := 1.
	SQLCS_IMPLICIT := 1.
	OCI_CRED_EXT := 2.
	OCI_FETCH_NEXT := 2.
	SQLCS_NCHAR := 2.
	OCI_HTYPE_ENV := 1.
	OCI_HTYPE_ERROR := 2.
	OCI_HTYPE_SVCCTX := 3.
	OCI_HTYPE_STMT := 4.
	OCI_HTYPE_DEFINE := 6.
	OCI_HTYPE_SERVER := 8.
	OCI_HTYPE_SESSION := 9.
	OCI_HTYPE_TRANS := 10.
	OCI_STRLS_CACHE_DELETE := 16. "0x0010 I hope this translates to 16?"
	OCI_COMMIT_ON_SUCCESS := 32.
	OCI_DTYPE_PARAM := 53. 
	OCI_STMT_SELECT := 1.
	OCI_STMT_BEGIN := 8.
	OCI_STMT_DECLARE := 9.
	OCI_STMT_CACHE := 64.
	OCI_NO_DATA := 100.
 
	
	"attributes"
	OCI_ATTR_DATA_SIZE := 1.
	OCI_ATTR_DATA_TYPE := 2.
	OCI_ATTR_NAME := 4. 
	OCI_ATTR_PRECISION := 5.
	OCI_ATTR_SCALE := 6. 
	OCI_ATTR_SERVER := 6.
	OCI_ATTR_IS_NULL := 7. 
	OCI_ATTR_SESSION := 7.
	OCI_ATTR_TRANS := 8. 
	OCI_ATTR_ROW_COUNT := 9. 
	OCI_ATTR_DATA_SIZE := 1.
	OCI_ATTR_USERNAME := 22.
	OCI_ATTR_PASSWORD := 23.
	OCI_ATTR_STMT_TYPE := 24.
	OCI_ATTR_CHARSET_FORM := 32.
	OCI_ATTR_WALL_LOC := 157. 
	OCI_ATTR_ROWS_FETCHED := 197.
 
	"transactions"
	OCI_TRANS_NEW          := 16r00000001. " start a new local or global txn "
 	OCI_TRANS_JOIN         := 16r00000002.     " join an existing global txn "
	OCI_TRANS_RESUME       := 16r00000004.    " resume the global txn branch "
	OCI_TRANS_PROMOTE      := 16r00000008. " promote the local txn to global "
	OCI_TRANS_STARTMASK    := 16r000000ff.  " mask for start operation flags "

	OCI_TRANS_READONLY     := 16r00000100.            " start a readonly txn "
	OCI_TRANS_READWRITE    := 16r00000200.          " start a read-write txn "
	OCI_TRANS_SERIALIZABLE := 16r00000400.        " start a serializable txn "
	OCI_TRANS_ISOLMASK     := 16r0000ff00.  " mask for start isolation flags "

	OCI_TRANS_LOOSE        := 16r00010000.        " a loosely coupled branch "
	OCI_TRANS_TIGHT        := 16r00020000.        " a tightly coupled branch "
	OCI_TRANS_TYPEMASK     := 16r000f0000.      " mask for branch type flags "

	OCI_TRANS_NOMIGRATE    := 16r00100000.      " non migratable transaction "
	OCI_TRANS_SEPARABLE    := 16r00200000.  " separable transaction (8.1.6+) "
	OCI_TRANS_OTSRESUME    := 16r00400000.      " OTS resuming a transaction "
	OCI_TRANS_OTHRMASK     := 16rfff00000.      " mask for other start flags "
	
	"errors"
	OCI_RTN_CODE_NULL_DATA := 1405.
	OCI_RTN_CODE_TRUNCATED_DATA := 1406.
]

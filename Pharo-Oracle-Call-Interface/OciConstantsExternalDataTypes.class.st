"
https://docs.oracle.com/cd/E11882_01/appdev.112/e10646.pdf
page 3-1
External data types are host language types that have been defined in the OCI header
files. When an OCI application binds input variables, one of the bind parameters is an
indication of the external data type code (or SQLT code) of the variable. Similarly, when
output variables are specified in a define call, the external representation of the
retrieved data must be specified.
"
Class {
	#name : #OciConstantsExternalDataTypes,
	#superclass : #Object,
	#classVars : [
		'SQLT_AFC',
		'SQLT_AVC',
		'SQLT_BDOUBLE',
		'SQLT_BFLOAT',
		'SQLT_BIN',
		'SQLT_BLOB',
		'SQLT_CHR',
		'SQLT_CLOB',
		'SQLT_DAT',
		'SQLT_DATE',
		'SQLT_FILE',
		'SQLT_FLT',
		'SQLT_INT',
		'SQLT_INTERVAL_DS',
		'SQLT_INTERVAL_YM',
		'SQLT_LAB',
		'SQLT_LBI',
		'SQLT_LNG',
		'SQLT_LVB',
		'SQLT_LVC',
		'SQLT_NTY',
		'SQLT_NUM',
		'SQLT_ODT3',
		'SQLT_RDD',
		'SQLT_REF',
		'SQLT_RID',
		'SQLT_STR',
		'SQLT_TIMESTAMP',
		'SQLT_TIMESTAMP_LTZ',
		'SQLT_TIMESTAMP_TZ',
		'SQLT_UIN',
		'SQLT_VBI',
		'SQLT_VCS',
		'SQLT_VNU',
		'SQLT_VST3'
	],
	#category : 'Pharo-Oracle-Call-Interface-Constants'
}

{ #category : #'class initialization' }
OciConstantsExternalDataTypes class >> initialize [
"https://docs.oracle.com/cd/E11882_01/appdev.112/e10646.pdf page 3-6"

"VARCHAR2 1 char[n]" SQLT_CHR := 1.

"NUMBER 2 unsigned char[21]" SQLT_NUM := 2.

"8-bit signed INTEGER 3 signed char" 
"16-bit signed INTEGER 3 signed short, signed int"
"32-bit signed INTEGER 3 signed int, signed long" 
"64-bit signed INTEGER 3 signed long, signed long long"  SQLT_INT := 3. 

"FLOAT 4 float, double" SQLT_FLT := 4.
"NULL-terminated STRING 5 char[n+1]" SQLT_STR := 5.
"VARNUM 6 char[22]" SQLT_VNU := 6.

"LONG 8 char[n]" SQLT_LNG := 8.
"VARCHAR 9 char[n+sizeof(short integer)]" SQLT_VCS := 9.

SQLT_RID := 11. "as defined in ocidfn.h"

"DATE 12 char[7]" SQLT_DAT := 12.
"VARRAW 15 unsigned char[n+sizeof(short integer)]" SQLT_VBI := 15.
"native float 21 float" SQLT_BFLOAT := 21.
"native double 22 double" SQLT_BDOUBLE := 22.
"RAW 23 unsigned char[n]" SQLT_BIN := 23.
"LONG RAW 24 unsigned char[n]" SQLT_LBI := 24.
"UNSIGNED INT 68 unsigned" SQLT_UIN := 68.
"LONG VARCHAR 94 char[n+sizeof(integer)]" SQLT_LVC := 94.
"LONG VARRAW 95 unsigned char[n+sizeof(integer)]" SQLT_LVB := 95.
"CHAR 96 char[n]" SQLT_AFC := 96.
"CHARZ 97 char[n+1]" SQLT_AVC := 97.
"ROWID descriptor 104 OCIRowid *" SQLT_RDD := 104.
"MLSLABEL 106 char[n]" SQLT_LAB := 106.
"NAMED DATATYPE 108 struct" SQLT_NTY := 108.
"REF 110 OCIRef" SQLT_REF := 110.
"Character LOB descriptor 112 OCILobLocator2" SQLT_CLOB := 112.
"Binary LOB descriptor 113 OCILobLocator2" SQLT_BLOB := 113.
"Binary FILE descriptor 114 OCILobLocator" SQLT_FILE := 114.
"OCI STRING type 155 OCIString" SQLT_VST3 := 155.
"OCI DATE type 156 OCIDate *" SQLT_ODT3 := 156.
"ANSI DATE descriptor 184 OCIDateTime *" SQLT_DATE := 184.
"TIMESTAMP descriptor 187 OCIDateTime *" SQLT_TIMESTAMP := 187.
"TIMESTAMP WITH TIME ZONE descriptor 188 OCIDateTime *" SQLT_TIMESTAMP_TZ := 188.
"INTERVAL YEAR TO MONTH descriptor 189 OCIInterval *" SQLT_INTERVAL_YM := 189.
"INTERVAL DAY TO SECOND descriptor 190 OCIInterval *" SQLT_INTERVAL_DS := 190.
"TIMESTAMP WITH LOCAL TIME ZONE descriptor 232 OCIDateTime *" SQLT_TIMESTAMP_LTZ := 232
]

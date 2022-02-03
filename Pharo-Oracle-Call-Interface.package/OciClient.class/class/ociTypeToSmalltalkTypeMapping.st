accessing
ociTypeToSmalltalkTypeMapping
	ociTypeToSmalltalkTypeMapping
		ifNil: [ ociTypeToSmalltalkTypeMapping := IdentityDictionary new
				add: SQLT_CHR -> #String;
				add: SQLT_NUM -> #Number;
				add: SQLT_LNG -> #String;
				add: SQLT_RID -> #String;
				add: SQLT_DAT -> #DateAndTime;
				add: SQLT_BIN -> #ByteArray;
				add: SQLT_LBI -> #ByteArray;
				add: SQLT_AFC -> #String;
				add: SQLT_RDD -> #String;
				add: SQLT_LAB -> #String;
				add: SQLT_CLOB -> #String;
				add: SQLT_BLOB -> #ByteArray;
				add: SQLT_TIMESTAMP -> #DateAndTime;
				yourself ].
	^ociTypeToSmalltalkTypeMapping
accessing
ociDefine
	super ociDefine.
	self client
		ociAttributeSetInteger:
			(isUnicode
				ifTrue: [ SQLCS_NCHAR ]
				ifFalse: [ SQLCS_IMPLICIT ])
		type: OCI_ATTR_CHARSET_FORM
		descriptor: self defineHandle
		type: OCI_HTYPE_DEFINE
		
	

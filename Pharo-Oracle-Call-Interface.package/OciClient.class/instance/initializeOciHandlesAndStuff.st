public
initializeOciHandlesAndStuff
	self environmentHandle: self ociEnvNlsCreate.
	self ociServerAttach.
	self
		ociAttributeSetHandle: self serverHandle
		type: OCI_ATTR_SERVER
		descriptor: self serviceContextHandle
		type: OCI_HTYPE_SVCCTX.
	self authenticationMode == OCI_CRED_RDBMS
		ifTrue: [ self username ifNil: [ self error: 'username missing' ].
			self password ifNil: [ self error: 'password missing' ].
			self
				ociAttributeSetString: self username
				type: OCI_ATTR_USERNAME
				descriptor: self sessionHandle
				type: OCI_HTYPE_SESSION.
			self
				ociAttributeSetString: self password
				type: OCI_ATTR_PASSWORD
				descriptor: self sessionHandle
				type: OCI_HTYPE_SESSION ].
	self
		ociAttributeSetHandle: self transactionHandle
		type: OCI_ATTR_TRANS
		descriptor: self serviceContextHandle
		type: OCI_HTYPE_SVCCTX.
	self
		ociAttributeSetHandle: self sessionHandle
		type: OCI_ATTR_SESSION
		descriptor: self serviceContextHandle
		type: OCI_HTYPE_SVCCTX.
	self ociSessionBegin
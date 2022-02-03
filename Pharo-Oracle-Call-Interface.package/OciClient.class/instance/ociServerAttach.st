oci calls
ociServerAttach
	| env returnValue |
	self ociAllocateAllHandles.
	self environmentString ifNil: [ self error: 'environmentString missing' ].
	env := self environmentString ifNotNil: [ :envString | envString nullTerminatedEncodeWith: #utf8].
	returnValue := Oci
		OCIServerAttach: self serverHandle
		errhp: self errorHandle
		dblink: env
		dblink_len: (env ifNotNil: [env size])
		mode: OCI_DEFAULT.
	returnValue == OCI_SUCCESS
		ifTrue: [ ^ self ].
	self handleErrorsWithReturnValue: returnValue
public
ociTerminate
"
self ociTerminate
"
	| rtval |
	rtval := self OCITerminate: OCI_DEFAULT "only valid value".
	rtval == OCI_SUCCESS
		ifTrue: [ ^ self ].
	self error: 'OCITerminate failed with code: ' , rtval displayString
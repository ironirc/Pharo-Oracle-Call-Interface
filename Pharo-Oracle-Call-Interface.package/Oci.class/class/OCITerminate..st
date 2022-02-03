ffi-calls
OCITerminate: mode
	^ self
		ffiCall: #(short OCITerminate #(byte mode))
	
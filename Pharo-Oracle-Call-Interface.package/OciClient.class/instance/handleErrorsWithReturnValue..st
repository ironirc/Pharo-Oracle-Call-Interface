oci calls
handleErrorsWithReturnValue: rv

	self getErrors ifNotNil: [ :errs | 
		errs isEmpty ifFalse: [ 
			self raiseErrorForErrors: errs returnValue: rv ] ]
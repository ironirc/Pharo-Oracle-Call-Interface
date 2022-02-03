error handling
raiseErrorForErrors: errors returnValue: returnValue
	OciError new
		errors: errors;
		returnValue: returnValue;
		signal: errors first fullDescription
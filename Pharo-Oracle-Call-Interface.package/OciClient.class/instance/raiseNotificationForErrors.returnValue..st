error handling
raiseNotificationForErrors: errors returnValue: returnValue
	OciNotification new
		errors: errors;
		returnValue: returnValue;
		signal: errors first fullDescription
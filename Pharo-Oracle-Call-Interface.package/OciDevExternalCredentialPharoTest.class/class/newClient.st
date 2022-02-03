tests
newClient
	| c |
	c := OciClient new
		"useCredentialsExternal;"
		environmentString: 'pharotst202112_medium';
		username: 'ADMIN';
		password: 'BmpPGNj3JsszzfF';
		yourself.
	c ociEnvNlsCreate.
	c connect.
	^ c
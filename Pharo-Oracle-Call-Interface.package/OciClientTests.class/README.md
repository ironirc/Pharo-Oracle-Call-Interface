I am OciClientTests, a collection of functional unit tests for OciClient.

I have to be configured in order to be able to run my tests:

```
OciClientTests factory: [ 
	OciClient new
		environmentString: 'pharotst202112_medium';
		username: 'SCOTT';
		password: 'TIGER';
		yourself ].
```

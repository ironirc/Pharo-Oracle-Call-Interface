I am OciClient, an Oracle Call Interface client for Pharo.

I use an FFI binding to the OCI client library.

```
| client rows |

client := OciClient new
	environmentString: 'pharotst202112_medium';
	username: 'SCOTT';
	password: 'TIGER';
	yourself.
rows := client query: 'SELECT * FROM emp'.		
client close.
rows.
```

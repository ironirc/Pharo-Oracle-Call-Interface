I am OciClient, an Oracle Call Interface client for Pharo.

I use an FFI binding to the OCI client library.

```
| client statement rows |

client := OciClient new
	environmentString: 'pharotst202112_medium';
	username: 'ADMIN';
	password: 'secret';
	yourself.

statement := client newPreparableStatementFor: 'SELECT * FROM table'.
statement	
	doWhilePrepared: [ rows := statement executeAndReturnRowsWithInput: nil ]
	shouldCache: false.
		
client close.
rows.
```

# Pharo-Oracle-Call-Interface

This library allows you to connect to an [Oracle SQL RDBMS](https://www.oracle.com/database/) 
from [Pharo](https://pharo.org) (versions 8 and up).
It provides a binding with Oracle's OCI using FFI.


## Usage

Once correctly installed on your local computer, you use OciClient to interact with the Oracle database:

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


## Installation

To install this library you clone this repository and load BaselineOfPharoOracleCallInterface.
This can be done using the Iceberg UI tools and with the following script:

```
Metacello new
  baseline: 'BaselineOfPharoOracleCallInterface';
  repository: 'github://Ironirc/Pharo-Oracle-Call-Interface';
  load.
```

You have to make sure that the Pharo VM can access/load the necessary native library for your platform.
The easiest way to get started is using [Oracle Instant Client](https://www.oracle.com/database/technologies/instant-client.html)
and an [Oracle Cloud](https://cloud.oracle.com) account.

## Status

Basic queries are working on 32 and 64 bit Windows and 64 bit macOS.

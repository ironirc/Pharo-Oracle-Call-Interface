"
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

These tests will create and fill the tables they need and clean up afterwards.
"
Class {
	#name : #OciClientTests,
	#superclass : #TestCase,
	#instVars : [
		'client'
	],
	#classVars : [
		'factory'
	],
	#category : 'Pharo-Oracle-Call-Interface-Testing'
}

{ #category : #accessing }
OciClientTests class >> factory [
	^ factory ifNil: [ factory := [ self error: 'Please set a factory to create a configured OciClient instance' ] ]
]

{ #category : #accessing }
OciClientTests class >> factory: block [
	"Set a factory to create a configured OciClient instance"
	
	^ factory := block
]

{ #category : #utilties }
OciClientTests >> dropTable: tableName [
	"DROP TABLE tableName IF EXISTS"
	
	| sql |
	sql := 'SELECT COUNT(*) FROM user_tables WHERE table_name = {1}' 
				format: { tableName asUppercase printString }.
	(client query: sql) first first = 1
		ifTrue: [
			sql := 'DROP TABLE {1}' format: { tableName }.
			client execute: sql ]
]

{ #category : #'instance creation' }
OciClientTests >> newClient [
	"Oci ociTerminate."
	^ self class factory value
]

{ #category : #running }
OciClientTests >> setUp [
	super setUp.
	client := self newClient
]

{ #category : #running }
OciClientTests >> tearDown [
	client close.
	super tearDown 
]

{ #category : #tests }
OciClientTests >> testConnectDisconnect [
	client connect.
	self assert: client isConnected.
	client close.
	self deny: client isConnected
]

{ #category : #tests }
OciClientTests >> testGetOracleVersion [
	| rows banner |
	rows := client query: 'SELECT banner_full FROM v$version'.
	banner := rows first first.
	self assert: (banner includesSubstring: 'Oracle').
	self assert: client isConnected
]

{ #category : #tests }
OciClientTests >> testSimpleQuery [
	| rows |
	self dropTable: 'hobby'.
	client execute: 'CREATE TABLE hobby (name VARCHAR2(100))'.
	client execute: 'INSERT INTO hobby(name) VALUES (''cooking'')'.
	rows := client query: 'SELECT * FROM hobby'.
	self assert: rows first equals: #( 'cooking' ).
	self dropTable: 'hobby'
]

{ #category : #tests }
OciClientTests >> testSimpleStatementWithNamedBindings [

	| statement rows airplane helicopter |
	self dropTable: 'table1'.
	airplane := OciClientTestsMockObject airplane.
	helicopter := OciClientTestsMockObject helicopter.
	client execute:
		'CREATE TABLE table1 (id number(10), name VARCHAR2(10))'.
	statement := client statementForSql:
		             'INSERT INTO table1( id, name) VALUES (:id, :name)'.
	statement doWhilePrepared: [ 
		"re-using cached statement"
		statement executeWith: airplane.
		statement executeWith: helicopter ].
	rows := client
		        query: 'SELECT name FROM table1 where id = :id '
		        with: airplane.
	self assert: rows first first equals: airplane name.
	rows := client
		        query: 'SELECT name FROM table1 where id = :id '
		        with: helicopter.
	self assert: rows first first equals: helicopter name.
	self dropTable: 'table1'
]

{ #category : #tests }
OciClientTests >> testSimpleStatementWithPositionalBindings [

	| statement rows |
	self dropTable: 'table1'.
	client execute:
		'CREATE TABLE table1 (id number(10), name VARCHAR2(10))'.
	statement := client statementForSql:
		             'INSERT INTO table1( id, name) VALUES (?, ?)'.
	statement prepareAndExecuteWith: #( 123 'abc' ).
	"re-using cached statement"
	statement prepareAndExecuteWith: #( 1234 'abcd' ).
	statement prepareAndExecuteWith: #( 12 'ab' ).
	rows := client
		        query: 'SELECT name FROM table1 where id = ? '
		        with: #( 123 ).
	self assert: rows first equals: #( 'abc' ).
	rows := client query: 'SELECT count(*) FROM table1'.
	self assert: rows first first equals: 3.
	rows := client query: 'SELECT name FROM table1 where id = 12'.
	self assert: rows first first equals: 'ab'.
	self dropTable: 'table1'
]

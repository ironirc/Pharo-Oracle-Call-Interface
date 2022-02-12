tests
testSimpleQuery
	| rows |
	self dropTable: 'hobby'.
	client execute: 'CREATE TABLE hobby (name VARCHAR2(100))'.
	client execute: 'INSERT INTO hobby(name) VALUES (''cooking'')'.
	rows := client query: 'SELECT * FROM hobby'.
	self assert: rows first equals: #( 'koken' ).
	self dropTable: 'hobby'
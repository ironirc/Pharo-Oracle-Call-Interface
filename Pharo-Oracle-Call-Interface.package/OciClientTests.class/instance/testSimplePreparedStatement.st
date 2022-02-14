tests
testSimplePreparedStatement
	| statement rows |
	self dropTable: 'table1'.
	client execute: 'CREATE TABLE table1 (id INTEGER, name VARCHAR2(10))'.
	statement := client prepare: 'INSERT INTO table1(id, name) VALUES (?, ?)'. "why not already prepare & cache immediately ?"
	statement
		doWhilePrepared: [ statement executeAndReturnRowsWithInput: #(1 'one') ]
 		shouldCache: true. "isCached set correctly ?"
	statement executeAndReturnRowsWithInput: #(2 'two').
	statement executeAndReturnRowsWithInput: #(3 'three').	
	statement close. "I added this before"
	statement := client prepare: 'SELECT name FROM table1 WHERE id = ?'.
	statement 
		doWhilePrepared: [ statement executeAndReturnRowsWithInput: #(2) ]
 		shouldCache: false.
	self assert: rows first equals: #( 'two' ).
	self dropTable: 'table1'
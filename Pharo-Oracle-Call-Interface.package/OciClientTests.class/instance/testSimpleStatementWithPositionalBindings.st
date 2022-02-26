tests
testSimpleStatementWithPositionalBindings

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
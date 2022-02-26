tests
testSimpleStatementWithNamedBindings

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
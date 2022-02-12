utilties
dropTable: tableName
	"DROP TABLE tableName IF EXISTS"
	
	| sql |
	sql := 'SELECT COUNT(*) FROM user_tables WHERE table_name = {1}' 
				format: { tableName asUppercase printString }.
	(client query: sql) first first = 1
		ifTrue: [
			sql := 'DROP TABLE {1}' format: { tableName }.
			client execute: sql ]
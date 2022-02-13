private
iterationCountForStatementExecution

	"https://docs.oracle.com/database/121/LNOCI/oci17msc001.htm#LNOCI17163"

	"iters (IN)
For non-SELECT statements, the number of times this statement is executed equals iters - rowoff.
For SELECT statements, if iters is nonzero, then defines must have been done for the statement handle. 
The execution fetches iters rows into these predefined buffers and prefetches more rows depending upon the prefetch row count. 
If you do not know how many rows the SELECT statement retrieves, then set iters to zero.
This function returns an error if iters=0 for non-SELECT statements.
Note: For array DML operations, set iters <= 32767 to get better performance."

	self isSelect ifTrue: [ ^ 0 ].
	self isPlsql ifTrue: [ ^ 1 ].
	(self bindings isNil or: [ self bindings isEmpty ]) ifTrue: [ ^ 1 ].
	self flag: 'TO DO: determine max size of bound input arrays, and return this value'.
	^ 1
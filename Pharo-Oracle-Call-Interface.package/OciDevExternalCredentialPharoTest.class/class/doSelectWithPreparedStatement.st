tests
doSelectWithPreparedStatement
	<script>

	| cl stmtAndBindObj ps rows |
	cl := self newClient.

	stmtAndBindObj := self statementSelectFromHobby.
	ps := cl newPreparableStatementFor: stmtAndBindObj .
	ps
		doWhilePrepared: [ rows := ps executeAndReturnRowsWithInput: nil.
			rows inspect]
		shouldCache: false.
	cl ociSessionEnd.
	cl ociServerDetach.
	cl ociFreeAllHandles
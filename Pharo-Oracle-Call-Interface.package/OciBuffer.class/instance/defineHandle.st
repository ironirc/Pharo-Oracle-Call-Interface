accessing derived
defineHandle
	"
https://docs.oracle.com/cd/E11882_01/appdev.112/e10646.pdf
Bind and define handles are implicitly allocated by the OCI library,
and are transparently reused if the bind or define operation is repeated.
The actual value of the bind or define handle is needed by the application
for the advanced bind or define operations described in Chapter 5.
The handles are freed when the statement handle is freed or when a new statement is prepared on the statement handle.
Explicitly allocating bind or define handles may lead to memory leaks.
Explicitly freeing bind or define handles may cause abnormal program termination"

	^self preparableStatement  defineHandle
public
prepareAndExecuteWith: anObject

	^ self doWhilePrepared: [ 
		  self executeWith: anObject ]
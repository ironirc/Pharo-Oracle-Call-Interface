public
freeRowBuffers
	self rowBuffers  do: [ :each | each release ]
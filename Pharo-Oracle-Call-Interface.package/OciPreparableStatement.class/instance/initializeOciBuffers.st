public
initializeOciBuffers

	| buffers |
	buffers := self columnDescriptions collect: [ :cd | 
		           (OciBuffer
			            newForColumnDescription: cd
			            preparableStatement: self)
			           preparableStatement: self;
			           allocateExternalMemoryForBlockFactor: self blockFactor;
			           ociDefine;
			           yourself ].
	self rowBuffers: buffers
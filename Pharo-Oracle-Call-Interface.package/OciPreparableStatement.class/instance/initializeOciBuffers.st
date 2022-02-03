public
initializeOciBuffers
	| buffers |
	buffers := self columnDescriptions
		collect: [ :cd | 
			(OciBuffer newForColumnDescription: cd preparableStatement: self)
				preparableStatement: self;
				allocateExternalMemory;
				ociDefine;
				yourself ].
	self rowBuffers: buffers
private
encoding
	self flag: 'incomplete'.
	^ isUnicode
		ifTrue: [ self client unicodeEncoding ]
		ifFalse: [ self client encoding ]
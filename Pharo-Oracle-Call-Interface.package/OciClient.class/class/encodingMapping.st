accessing
encodingMapping
	^ Dictionary new
		add: 'UTF8' -> #utf_8;
		add: 'AL32UTF8' -> #utf_8;
		add: 'UTF16' -> #utf_16;
		yourself
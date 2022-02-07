accessing
znCharacterEncoder
	(#(utf_8 default) includes: self encoding)
		ifTrue: [ ^ ZnCharacterEncoder utf8 ].
	self encoding == #utf_16
		ifTrue: [ ^ ZnCharacterEncoder newForEncoding: 'utf16' ].
	"add more as needed"
	self error: 'unkown encoding: ' , self encoding
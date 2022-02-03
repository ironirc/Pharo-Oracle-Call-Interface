accessing
znCharacterEncoder
	self encoding == #utf_8
		ifTrue: [ ^ ZnCharacterEncoder utf8 ].
	self encoding == #utf_16
		ifTrue: [ ^ ZnCharacterEncoder newForEncoding: 'utf16' ].
	"add more as needed"
	self error: 'unkown encoding'
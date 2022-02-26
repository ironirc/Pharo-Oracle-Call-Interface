private
readSymbolFromStream: aStream

	^ Symbol streamContents: [ :ws | 
		  | c |
		  c := aStream next.
		  (c isLetter or: [ c == $_ ])
			  ifTrue: [ ws nextPut: c ]
			  ifFalse: [ self error: 'unexpected char while reading symbol' ].
		  [ 
		  aStream atEnd not and: [ 
			  aStream peek isAlphaNumeric or: [ c == $_ ] ] ] whileTrue: [ 
			  c := aStream next.
			  ws nextPut: c ] ]
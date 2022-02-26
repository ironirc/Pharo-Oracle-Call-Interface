private
setStatementString: aString

	| rs ch prevCh statement |
	bindings := OrderedCollection new.

	rs := aString readStream.
	ch := $?.
	statement := String streamContents: [ :ws | 
		             [ rs atEnd ] whileFalse: [ 
			             prevCh := ch.
			             ch := rs next.
			             ({ $'. $" } includes: ch)
				             ifTrue: [ "single or double quoted strings can not contain bindings, just copy"
					             ws nextPut: ch.
					             ws nextPutAll: (rs upTo: ch).
					             ws nextPut: ch ]
				             ifFalse: [ 
					             ch == $?
						             ifTrue: [ 
							             | binding |
							             "relative positioned ? marker"
							             binding := self addBindingByPosition: bindings size + 1.
							             binding writeMarkerOn: ws ]
						             ifFalse: [ 
							             (ch == $: and: [ 
								              prevCh isAlphaNumeric not and: [ 
									              prevCh ~= $: and: [ 
										              rs atEnd not and: [ rs peek isAlphaNumeric ] ] ] ])
								             ifTrue: [ 
									             | binding |
									             "It's a valid : marker"
									             binding := rs peek isDigit
										                   ifTrue: [ "absolute positioned marker " 
											                   self addBindingByPosition:
												                   (Integer readFrom: rs) ]
										                   ifFalse: [ "named marker" 
											                   self addBindingByName:
												                   (self readSymbolFromStream: rs) ].
									             binding writeMarkerOn: ws ]
								             ifFalse: [ ws nextPut: ch ] ] ] ] ].
	self statementString: statement
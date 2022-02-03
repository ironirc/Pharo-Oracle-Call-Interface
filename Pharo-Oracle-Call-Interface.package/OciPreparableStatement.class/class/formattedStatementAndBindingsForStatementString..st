private
formattedStatementAndBindingsForStatementString: aString
	| rs ch prevCh bindings statement |
	bindings := OrderedCollection new.
	rs := aString readStream.
	ch := $?.
	statement := String
		streamContents: [ :ws | 
			[ rs atEnd ]
				whileFalse: [ prevCh := ch.
					ch := rs next.
					({$' . $"} includes: ch)
						ifTrue: [ "single or double quoted strings can not contain bindings, just copy"
							ws nextPut: ch.
							ws nextPutAll: (rs upTo: ch).
							ws nextPut: ch ]
						ifFalse: [ ch == $?
								ifTrue: [ | bs |
									"relative positioned ? marker"
									bs := OciBindingByPosition new position: bindings size + 1.
									bindings add: bs.
									bs writeMarkerOn: ws ]
								ifFalse: [ (ch == $: and: [ (prevCh isAlphaNumeric not and: [ (prevCh == $:) not ]) and: [ rs atEnd not and: [ rs peek isAlphaNumeric ] ] ])
										ifTrue: [ | bs |
											"It's a valid : marker"
											bs := rs peek isDigit
												ifTrue: [ "absolute positioned marker " OciBindingByPosition new position: (Integer readFrom: rs) ]
												ifFalse: [ "named marker" OciBindingByName new name: (self readSymbolFromStream: rs) ].
											bindings add: bs.
											bs writeMarkerOn: ws ]
										ifFalse: [ ws nextPut: ch ] ] ] ] ].
	^ statement -> bindings
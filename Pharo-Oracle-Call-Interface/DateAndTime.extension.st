Extension { #name : #DateAndTime }

{ #category : #'*Pharo-Oracle-Call-Interface' }
DateAndTime >> asOciDateByteArray [
"
DateAndTime now asOciDateByteArray inspect
"

	| result |
	result := ByteArray new: 7.
	self
		dayMonthYearDo: [ :d :m :y | 
			result at: 1 put: y // 100 + 100.
			result at: 2 put: y \\ 100 + 100.
			result at: 3 put: m.
			result at: 4 put: d ].
	result at: 5 put: self hour + 1.
	result at: 6 put: self minute + 1.
	result at: 7 put: self second + 1.
	^ result
]

{ #category : #'*Pharo-Oracle-Call-Interface' }
DateAndTime >> ociBufferClass [
	^OciBufferDate
]

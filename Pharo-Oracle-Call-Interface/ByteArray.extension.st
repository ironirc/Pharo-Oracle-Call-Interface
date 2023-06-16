Extension { #name : #ByteArray }

{ #category : #'*Pharo-Oracle-Call-Interface' }
ByteArray >> decodedFromOciDate [
	^ DateAndTime
		year: ((self at: 1) - 100) * 100 + ((self at: 2) - 100)
		month: (self at: 3)
		day: (self at: 4)
		hour: (self at: 5) - 1
		minute: (self at: 6) - 1
		second: (self at: 7) - 1
]

{ #category : #'*Pharo-Oracle-Call-Interface' }
ByteArray >> decodedFromOciVarNum [
	| exponentByte length isPositive exponent mantissaSize result |
	length := self at: 1.
	length == 1
		ifTrue: [ ^ 0 ].
	exponentByte := self at: 2.
	isPositive := (exponentByte bitAnd: 128) == 128.
	exponent := isPositive
		ifTrue: [ (exponentByte bitAnd: 127) - 65 ]
		ifFalse: [ ((exponentByte bitAnd: 127) bitXor: 255) - 65 - 128 ].
	mantissaSize := isPositive
		ifTrue: [ length - 1 ]
		ifFalse: [ length - 2 ].
	result := 0.
	1 to: mantissaSize do: [ :idx | 
		| mantissaByte mantissa |
		mantissaByte := self at: idx + 2.
		mantissa := isPositive
			ifTrue: [ mantissaByte - 1 ]
			ifFalse: [ 101 - mantissaByte ].
		result := result + (100 ** (exponent - idx + 1) * mantissa) ].
	^ isPositive
		ifTrue: [ result ]
		ifFalse: [ result negated ]
]

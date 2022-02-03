*Pharo-Oracle-Call-Interface
decodedFromOciVarNum
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
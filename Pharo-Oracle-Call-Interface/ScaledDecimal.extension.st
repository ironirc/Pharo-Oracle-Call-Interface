Extension { #name : #ScaledDecimal }

{ #category : #'*Pharo-Oracle-Call-Interface' }
ScaledDecimal >> asOciVarNumByteArray [
	| exponent value |
	self isZero
		ifTrue: [ ^ #[1 128] ].
	exponent := (self scale + 1) // 2.
	value := exponent isZero
		ifFalse: [ (self * (100 ** exponent)) asInteger ]
		ifTrue: [ self ].
	^ value asOciVarNumByteArrayWithExponent: exponent isNegative: value < 0
]

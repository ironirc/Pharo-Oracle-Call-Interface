*Pharo-Oracle-Call-Interface
asOciVarNumByteArray
	self isZero
		ifTrue: [ ^ #[1 128] ].
	^ self asOciVarNumByteArrayWithExponent: 0 isNegative: self < 0
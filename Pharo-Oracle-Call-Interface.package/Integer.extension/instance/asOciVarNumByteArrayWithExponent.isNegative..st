*Pharo-Oracle-Call-Interface
asOciVarNumByteArrayWithExponent: exponent isNegative: isNegative
	"https://docs.oracle.com/en/database/oracle/oracle-database/12.2/lnoci/data-types.html#GUID-91151345-2C67-41BC-A782-AD4816B89BCF"

	| resultArray currentValue numberOfMantissaBytes mantissaByte resultLength |
	"	self isZero
		ifTrue: [ ^ #[1 128 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] ]."
	self < 0
		ifTrue: [ ^ self negated asOciVarNumByteArrayWithExponent: exponent isNegative: true ].
	[ self \\ 100 == 0 ] whileTrue: [ ^ self // 100 asOciVarNumByteArrayWithExponent: exponent - 1 isNegative: isNegative ].
	numberOfMantissaBytes := (self decimalDigitLength + 1) // 2.	"one byte per 2 digits"
	resultLength := numberOfMantissaBytes + 2.
	isNegative
		ifTrue: [ resultLength < 22
				ifTrue: [ resultLength := resultLength + 1 ] ].
	resultArray := ByteArray new: resultLength.
	currentValue := self.
	resultArray
		at: 1
		put:
			(numberOfMantissaBytes
				+
					(isNegative
						ifTrue: [ 2 ]
						ifFalse: [ 1 ]) min: 21).
	resultArray
		at: 2
		put:
			(isNegative
				ifTrue: [ 63 - (numberOfMantissaBytes - exponent) ]
				ifFalse: [ 192 + (numberOfMantissaBytes - exponent) ]).
	numberOfMantissaBytes + 2 to: 3 by: -1 do: [ :mantissaIndex | 
		mantissaByte := currentValue \\ 100.
		resultArray
			at: mantissaIndex
			put:
				(isNegative
					ifTrue: [ 101 - mantissaByte ]
					ifFalse: [ mantissaByte + 1 ]).
		currentValue := currentValue // 100 ].
	"negative numbers with less than 20 mantissa bytes get terminated with byte 102"
	(isNegative and: [ numberOfMantissaBytes < 20 ])
		ifTrue: [ resultArray at: numberOfMantissaBytes + 3 put: 102 ].
	^ resultArray
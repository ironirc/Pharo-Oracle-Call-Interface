Class {
	#name : #OciColumnDescription,
	#superclass : #Object,
	#instVars : [
		'name',
		'internalType',
		'type',
		'precision',
		'scale',
		'isUnicodeColumn',
		'session',
		'position',
		'isNullable',
		'maxNumberOfBytes'
	],
	#pools : [
		'OciConstantsExternalDataTypes',
		'OciConstantsInternalDataTypes'
	],
	#category : 'Pharo-Oracle-Call-Interface-Core'
}

{ #category : #initialization }
OciColumnDescription >> initialize [

	precision := 0.
	scale := 0.
	isUnicodeColumn := false
]

{ #category : #accessing }
OciColumnDescription >> internalType [
	^ internalType
]

{ #category : #accessing }
OciColumnDescription >> internalType: anObject [
	internalType := anObject
]

{ #category : #testing }
OciColumnDescription >> isInteger [
	^ self type == #Number and: [ self scale isZero ]
]

{ #category : #accessing }
OciColumnDescription >> isNullable [
	^ isNullable
]

{ #category : #accessing }
OciColumnDescription >> isNullable: anObject [
	isNullable := anObject
]

{ #category : #testing }
OciColumnDescription >> isScaledDecimal [
	^ self type == #Number and: [ self scale isZero not ]
]

{ #category : #testing }
OciColumnDescription >> isString [
	^self type == #String
]

{ #category : #accessing }
OciColumnDescription >> isUnicodeColumn [
	^ isUnicodeColumn
]

{ #category : #accessing }
OciColumnDescription >> isUnicodeColumn: anObject [
	isUnicodeColumn := anObject
]

{ #category : #accessing }
OciColumnDescription >> maxNumberOfBytes [
	^ maxNumberOfBytes
]

{ #category : #accessing }
OciColumnDescription >> maxNumberOfBytes: anObject [
	maxNumberOfBytes := anObject
]

{ #category : #accessing }
OciColumnDescription >> name [
	^ name
]

{ #category : #accessing }
OciColumnDescription >> name: anObject [
	name := anObject
]

{ #category : #accessing }
OciColumnDescription >> position [
	^ position
]

{ #category : #accessing }
OciColumnDescription >> position:  anObject [
	position := anObject
]

{ #category : #accessing }
OciColumnDescription >> precision [
	^ precision
]

{ #category : #accessing }
OciColumnDescription >> precision: anObject [
	precision := anObject
]

{ #category : #accessing }
OciColumnDescription >> scale [
	^ scale
]

{ #category : #accessing }
OciColumnDescription >> scale: anObject [
	scale := anObject
]

{ #category : #accessing }
OciColumnDescription >> session [
	^ session
]

{ #category : #accessing }
OciColumnDescription >> session: anObject [
	session := anObject
]

{ #category : #accessing }
OciColumnDescription >> type [
	^ type
]

{ #category : #accessing }
OciColumnDescription >> type: anObject [
	type := anObject
]

Class {
	#name : #OciBufferScaledDecimal,
	#superclass : #OciBufferVarnum,
	#instVars : [
		'scale'
	],
	#category : 'Pharo-Oracle-Call-Interface-Buffers'
}

{ #category : #accessing }
OciBufferScaledDecimal >> initializeWithColumnDescription: cd [
	super initializeWithColumnDescription: cd. 
	scale := cd scale

]

{ #category : #accessing }
OciBufferScaledDecimal >> valueFromBufferAtRow: rowIndex [
	^ScaledDecimal newFromNumber: (super valueFromBufferAtRow: rowIndex) scale: scale
]

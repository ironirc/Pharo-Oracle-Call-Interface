Class {
	#name : #OciConstantsCTypes,
	#superclass : #Object,
	#classVars : [
		'dvoid',
		'eword',
		'sb1',
		'sb2',
		'sb4',
		'sword',
		'ub1',
		'ub2',
		'ub4',
		'uword'
	],
	#category : #'Pharo-Oracle-Call-Interface-Constants'
}

{ #category : #initialization }
OciConstantsCTypes class >> initialize [
	sb4 := #int.
	sword := #int.
	ub4 := #uint.
	eword := #uint.
	uword := #uint.
	sb2 := #signedShort.
	ub2 := #unsignedShort.
	sb1 := #signedByte.
	ub1 := #unsignedByte
]

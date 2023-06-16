Class {
	#name : #SB2Struct,
	#superclass : #FFIExternalStructure,
	#category : #'Pharo-Oracle-Call-Interface-UFFI'
}

{ #category : #evaluating }
SB2Struct >> value [
    ^ self int16At: 1
]

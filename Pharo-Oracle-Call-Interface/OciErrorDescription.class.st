Class {
	#name : #OciErrorDescription,
	#superclass : #Object,
	#instVars : [
		'code',
		'description'
	],
	#category : 'Pharo-Oracle-Call-Interface-Core'
}

{ #category : #accessing }
OciErrorDescription >> code [
	^ code
]

{ #category : #accessing }
OciErrorDescription >> code: anObject [
	code := anObject
]

{ #category : #accessing }
OciErrorDescription >> description [
	^ description
]

{ #category : #accessing }
OciErrorDescription >> description: anObject [
	description := anObject
]

{ #category : #printing }
OciErrorDescription >> fullDescription [
	^ String streamContents: [ :ws | ws << self code displayString << ' - ' << self description ]
]

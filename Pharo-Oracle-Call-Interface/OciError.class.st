Class {
	#name : #OciError,
	#superclass : #Error,
	#instVars : [
		'errors',
		'returnValue'
	],
	#category : 'Pharo-Oracle-Call-Interface-Exceptions'
}

{ #category : #accessing }
OciError >> errors [
	^ errors
]

{ #category : #accessing }
OciError >> errors: anObject [
	errors := anObject
]

{ #category : #accessing }
OciError >> returnValue [
	^ returnValue
]

{ #category : #accessing }
OciError >> returnValue: anObject [
	returnValue := anObject
]

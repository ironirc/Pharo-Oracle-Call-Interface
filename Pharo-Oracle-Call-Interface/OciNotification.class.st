Class {
	#name : #OciNotification,
	#superclass : #Notification,
	#instVars : [
		'errors',
		'returnValue'
	],
	#category : 'Pharo-Oracle-Call-Interface-Exceptions'
}

{ #category : #accessing }
OciNotification >> returnValue [
	^ returnValue
]

{ #category : #accessing }
OciNotification >> returnValue: anObject [
	returnValue := anObject
]

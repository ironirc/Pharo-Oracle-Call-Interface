Class {
	#name : #OciClientTestsMockObject,
	#superclass : #Object,
	#instVars : [
		'id',
		'name'
	],
	#category : 'Pharo-Oracle-Call-Interface-Testing'
}

{ #category : #'as yet unclassified' }
OciClientTestsMockObject class >> airplane [

	^ self new
		  id: 123;
		  name: 'airplane';
		  yourself
]

{ #category : #'as yet unclassified' }
OciClientTestsMockObject class >> helicopter [

	^ self new
		  id: 456;
		  name: 'helicopter';
		  yourself
]

{ #category : #accessing }
OciClientTestsMockObject >> id [
	^ id
]

{ #category : #accessing }
OciClientTestsMockObject >> id: anObject [
	id := anObject
]

{ #category : #accessing }
OciClientTestsMockObject >> name [

	^ name
]

{ #category : #accessing }
OciClientTestsMockObject >> name: anObject [

	name := anObject
]

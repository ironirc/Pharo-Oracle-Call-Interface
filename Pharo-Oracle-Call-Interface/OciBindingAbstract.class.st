Class {
	#name : #OciBindingAbstract,
	#superclass : #Object,
	#instVars : [
		'bindPointer',
		'buffer',
		'statement'
	],
	#pools : [
		'OciConstants'
	],
	#category : #'Pharo-Oracle-Call-Interface-Core'
}

{ #category : #private }
OciBindingAbstract >> ensureBindPointerInitializedWithValue: anObject [

	self subclassResponsibility
]

{ #category : #private }
OciBindingAbstract >> ensureBindingForInputObject: anObject [

	| val |

	val := self getValueFromInput: anObject.
	val ifNotNil: [((val isKindOf: String) and: [ val size = 23]) ifTrue: [ self halt ]].
	self ensureBufferInitializedForValue: val.
	self ensureBindPointerInitializedWithValue: val.
	val ifNil: [ ^self ].
	buffer value: val toBufferAtRow: 1
]

{ #category : #private }
OciBindingAbstract >> ensureBufferInitializedForValue: val [
	val ifNil: [ ^self "Ivo 08-05-2023 not sure..."].
	buffer ifNil: [ 
		| buff |
		buff := val ociBufferClass new.
		buff preparableStatement: self statement.
		buff setSingleBufferSizeForValue: val.
		buff allocateExternalMemoryForBlockFactor: 1.
		buffer := buff ]
]

{ #category : #private }
OciBindingAbstract >> getValueFromInput: anObject [

	self subclassResponsibility
]

{ #category : #initialization }
OciBindingAbstract >> initialize [
	super initialize.
	bindPointer := ExternalAddress new
]

{ #category : #initialization }
OciBindingAbstract >> release [ 
	super release.
	bindPointer := nil
]

{ #category : #accessing }
OciBindingAbstract >> statement [

	^ statement
]

{ #category : #accessing }
OciBindingAbstract >> statement: anObject [

	statement := anObject
]

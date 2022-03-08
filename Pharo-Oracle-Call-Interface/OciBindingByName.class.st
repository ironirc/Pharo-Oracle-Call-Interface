Class {
	#name : #OciBindingByName,
	#superclass : #OciBindingAbstract,
	#instVars : [
		'name'
	],
	#category : 'Pharo-Oracle-Call-Interface-Core'
}

{ #category : #private }
OciBindingByName >> ensureBindPointerInitialized [

	| bindName returnValue |
	bindName := self name utf8Encoded.
	returnValue := Oci
		               OCIBindByName: self statement statementHandle
		               bindpp: bindPointer
		               errhp: self statement client errorHandle
		               placeholder: bindName
		               placeh_len: bindName size
		               valuep: buffer baseAddressOfBufferArray
		               value_sz: buffer singleBufferSize
		               dty: buffer class externalDatabaseType
		               indp: nil
		               alenp: nil
		               rcodep: nil
		               maxarr_len: 0
		               curelep: nil
		               mode: OCI_DEFAULT.
	returnValue == OCI_SUCCESS ifTrue: [ ^ self ].
	self statement client handleErrorsWithReturnValue: returnValue
]

{ #category : #printing }
OciBindingByName >> getValueFromInput: anObject [
	^ anObject perform: self name asSymbol
]

{ #category : #accessing }
OciBindingByName >> name [
	^ name
]

{ #category : #accessing }
OciBindingByName >> name: anObject [
	name := anObject
]

{ #category : #printing }
OciBindingByName >> writeMarkerOn: ws [
	ws nextPut: $:.
	ws nextPutAll: self name
]

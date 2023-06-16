Class {
	#name : #OciBindingByPosition,
	#superclass : #OciBindingAbstract,
	#instVars : [
		'position'
	],
	#category : #'Pharo-Oracle-Call-Interface-Core'
}

{ #category : #private }
OciBindingByPosition >> ensureBindPointerInitializedWithValue: anObject [

	| returnValue |
	bindPointer isNull ifFalse: [ ^ self ].
	returnValue := Oci
		               OCIBindByPos: self statement statementHandle
		               bindpp: bindPointer
		               errhp: self statement client errorHandle
		               position: position
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

{ #category : #private }
OciBindingByPosition >> getValueFromInput: anObject [
	^ anObject at: self position
]

{ #category : #accessing }
OciBindingByPosition >> position [
	^ position
]

{ #category : #accessing }
OciBindingByPosition >> position: anObject [
	position := anObject
]

{ #category : #private }
OciBindingByPosition >> writeMarkerOn: ws [

	ws nextPutAll: ':var'.
	self position printOn: ws
]

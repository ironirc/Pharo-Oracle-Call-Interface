Class {
	#name : #OciBindingByName,
	#superclass : #OciBindingAbstract,
	#instVars : [
		'name'
	],
	#category : #'Pharo-Oracle-Call-Interface-Core'
}

{ #category : #private }
OciBindingByName >> ensureBindPointerInitializedWithValue: aValue [

	| bindName indp returnValue |
	bindName := self name utf8Encoded.
	indp := aValue
		        ifNil: [
			        FFIInt16 newBuffer
				        signedShortAt: 1 put: -1;
				        yourself ]
		        ifNotNil: [ 0 ].
	returnValue := Oci
		               OCIBindByName: self statement statementHandle
		               bindpp: bindPointer
		               errhp: self statement client errorHandle
		               placeholder: bindName
		               placeh_len: bindName size
		               valuep:
		               (buffer
			                ifNil: [ 0 ]
			                ifNotNil: [ buffer baseAddressOfBufferArray ])
		               value_sz:
		               (buffer
			                ifNil: [ 0 ]
			                ifNotNil: [ buffer singleBufferSize ])
		               dty:
		               (buffer
			                ifNil: [ 5 ]
			                ifNotNil: [ buffer class externalDatabaseType ])
		               indp: indp
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
OciBindingByName >> printOn: ws [
	super printOn: ws. 
	ws << ' ('.
	ws << name.
	ws << ')'
]

{ #category : #printing }
OciBindingByName >> writeMarkerOn: ws [
	ws nextPut: $:.
	ws nextPutAll: self name
]

Class {
	#name : #OciBufferChar,
	#superclass : #OciBufferVarchar2,
	#category : 'Pharo-Oracle-Call-Interface-Buffers'
}

{ #category : #constants }
OciBufferChar class >> externalDatabaseType [
	^SQLT_VCS 
]

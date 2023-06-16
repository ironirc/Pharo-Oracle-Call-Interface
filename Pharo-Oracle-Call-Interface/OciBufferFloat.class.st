Class {
	#name : #OciBufferFloat,
	#superclass : #OciBuffer,
	#category : 'Pharo-Oracle-Call-Interface-Buffers'
}

{ #category : #accessing }
OciBufferFloat >> initializeWithColumnDescription: cd [
	super initializeWithColumnDescription: cd.
	externalType := SQLT_FLT.
	singleBufferSize := 4
]

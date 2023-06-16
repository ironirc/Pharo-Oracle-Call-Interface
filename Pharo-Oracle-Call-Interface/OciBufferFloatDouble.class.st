Class {
	#name : #OciBufferFloatDouble,
	#superclass : #OciBuffer,
	#category : 'Pharo-Oracle-Call-Interface-Buffers'
}

{ #category : #accessing }
OciBufferFloatDouble >> initializeWithColumnDescription: cd [
	super initializeWithColumnDescription: cd.
	externalType := SQLT_FLT.
	singleBufferSize := 8
]

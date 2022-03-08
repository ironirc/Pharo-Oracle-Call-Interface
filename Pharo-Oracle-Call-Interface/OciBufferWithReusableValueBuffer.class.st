Class {
	#name : #OciBufferWithReusableValueBuffer,
	#superclass : #OciBuffer,
	#instVars : [
		'valueBuffer'
	],
	#category : 'Pharo-Oracle-Call-Interface-Buffers'
}

{ #category : #'initialize-release' }
OciBufferWithReusableValueBuffer >> release [
	super release.
	valueBuffer := nil
]

{ #category : #accessing }
OciBufferWithReusableValueBuffer >> targetAddressForRow: rowIndex [
	^ baseAddressOfBufferArray + ((rowIndex - 1) * singleBufferSize)
]

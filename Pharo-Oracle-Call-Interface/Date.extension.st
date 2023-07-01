Extension { #name : #Date }

{ #category : #'*Pharo-Oracle-Call-Interface' }
Date >> asOciDateByteArray [
	^ self asDateAndTime asOciDateByteArray
]

{ #category : #'*Pharo-Oracle-Call-Interface' }
Date >> ociBufferClass [
	^OciBufferDate
]

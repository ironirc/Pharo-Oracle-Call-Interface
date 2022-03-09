Class {
	#name : #OciBufferEncodedString,
	#superclass : #OciBuffer,
	#category : #'Pharo-Oracle-Call-Interface-Buffers'
}

{ #category : #accessing }
OciBufferEncodedString >> decodedValueBuffer: aByteArray [
	^ aByteArray decodeWith: self znCharacterEncoder
]

{ #category : #accessing }
OciBufferEncodedString >> encodeStringAsByteArray: aString [
	^ "self znCharacterEncoder encodeString: aString"
	aString nullTerminatedEncodeWith: #utf8
]

{ #category : #private }
OciBufferEncodedString >> encoding [

	self flag: 'revise'.
	^ self columnDescription isUnicodeColumn
		  ifTrue: [ self halt ]
		  ifFalse: [ self client encoding ]
]

{ #category : #'initialize-release' }
OciBufferEncodedString >> initialize [
	super initialize.

]

{ #category : #testing }
OciBufferEncodedString >> isEncodingUtf16 [

	^ self encoding = #utf_16
]

{ #category : #accessing }
OciBufferEncodedString >> needsDoubleBufferSize [

	self flag: 'revise'.
	^ self isEncodingUtf16 = self columnDescription isUnicodeColumn
]

{ #category : #accessing }
OciBufferEncodedString >> ociDefine [

	super ociDefine.
	self client
		ociAttributeSetInteger: (self columnDescription isUnicodeColumn
				 ifTrue: [ SQLCS_NCHAR ]
				 ifFalse: [ SQLCS_IMPLICIT ])
		type: OCI_ATTR_CHARSET_FORM
		descriptor: self defineHandle
		type: OCI_HTYPE_DEFINE
]

{ #category : #accessing }
OciBufferEncodedString >> valueFromBufferAtRow: rowIndex [
	^ self subclassResponsibility
]

{ #category : #accessing }
OciBufferEncodedString >> znCharacterEncoder [

	(#( utf_8 default ) includes: self encoding) ifTrue: [ 
		^ ZnCharacterEncoder utf8 ].
	self isEncodingUtf16 ifTrue: [ 
		^ ZnCharacterEncoder newForEncoding: 'utf16' ].
	"add more as needed"
	self error: 'unkown encoding: ' , self encoding
]

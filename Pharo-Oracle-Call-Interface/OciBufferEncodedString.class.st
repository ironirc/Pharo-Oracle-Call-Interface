Class {
	#name : #OciBufferEncodedString,
	#superclass : #OciBuffer,
	#instVars : [
		'isUnicode'
	],
	#category : 'Pharo-Oracle-Call-Interface-Buffers'
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
	self flag: 'incomplete'.
	^ isUnicode
		ifTrue: [ self client unicodeEncoding ]
		ifFalse: [ self client encoding ]
]

{ #category : #'initialize-release' }
OciBufferEncodedString >> initialize [
	super initialize.
	isUnicode := false
]

{ #category : #'initialize-release' }
OciBufferEncodedString >> initializeWithColumnDescription: cd [
	super initializeWithColumnDescription: cd.
	isUnicode := cd isUnicodeColumn
]

{ #category : #accessing }
OciBufferEncodedString >> needsDoubleBufferSize [
	self flag: 'revise'.
	^ self encoding = #utf_16 = isUnicode
]

{ #category : #accessing }
OciBufferEncodedString >> ociDefine [
	super ociDefine.
	self client
		ociAttributeSetInteger:
			(isUnicode
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
	(#(utf_8 default) includes: self encoding)
		ifTrue: [ ^ ZnCharacterEncoder utf8 ].
	self encoding == #utf_16
		ifTrue: [ ^ ZnCharacterEncoder newForEncoding: 'utf16' ].
	"add more as needed"
	self error: 'unkown encoding: ' , self encoding
]

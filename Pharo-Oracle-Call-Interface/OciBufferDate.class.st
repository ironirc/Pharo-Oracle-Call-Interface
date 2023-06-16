Class {
	#name : #OciBufferDate,
	#superclass : #OciBufferWithReusableValueBuffer,
	#category : #'Pharo-Oracle-Call-Interface-Buffers'
}

{ #category : #constants }
OciBufferDate class >> externalDatabaseType [
	^SQLT_DAT
]

{ #category : #initialization }
OciBufferDate >> initialize [

	super initialize.
	externalType := SQLT_DAT.
	singleBufferSize := 7.
	valueBuffer := ByteArray new: 7
]

{ #category : #malloc }
OciBufferDate >> initializeWithColumnDescription: cd [
	super initializeWithColumnDescription: cd.
	externalType := SQLT_DAT.
	singleBufferSize := 7.
	valueBuffer := ByteArray new: 7 
]

{ #category : #malloc }
OciBufferDate >> value: aValue toBufferAtRow: rowIndex [
	| byteArray |
	byteArray := aValue asOciDateByteArray.
	LibC memCopy: byteArray to: (self targetAddressForRow: rowIndex) size: byteArray size 
]

{ #category : #malloc }
OciBufferDate >> valueFromBufferAtRow: rowIndex [
	LibC memCopy: (self targetAddressForRow: rowIndex) to: valueBuffer size: singleBufferSize.
	^ valueBuffer decodedFromOciDate "returns a DateAndTime object" 
]

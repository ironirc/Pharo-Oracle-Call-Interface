"
I am OciEncodingTests
"
Class {
	#name : #OciEncodingTests,
	#superclass : #TestCase,
	#category : 'Pharo-Oracle-Call-Interface-Testing'
}

{ #category : #tests }
OciEncodingTests >> testVarNumDecoding [
	self valuePairsToTest do: [ :assoc | self assert: assoc key decodedFromOciVarNum equals: assoc value ]
]

{ #category : #tests }
OciEncodingTests >> testVarNumEncoding [
	self valuePairsToTest
		do: [ :assoc | self assert: assoc value asOciVarNumByteArray equals: ("self paddWithTrailingZerosUntilSize22:" assoc key) ]
]

{ #category : #tests }
OciEncodingTests >> valuePairsToTest [
	^ {(#[1 128] -> 0).
	(#[2 193 6] -> 5).
	(#[3 62 96 102] -> -5).
	(#[3 194 28 68] -> 2767).
	(#[4 61 74 34 102] -> -2767).
	(#[2 195 11] -> 100000).
	(#[5 196 2 24 46 68] -> 1234567).
	(#[5 195 2 24 46 68] -> 12345.67s).
	(#[5 195 2 24 46 61] -> 12345.6s).
	(#[6 60 100 78 56 34 102] -> -12345.67s)}
]

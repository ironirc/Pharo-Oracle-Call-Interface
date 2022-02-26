accessing
encodeStringAsByteArray: aString
	^ "self znCharacterEncoder encodeString: aString"
	aString nullTerminatedEncodeWith: #utf8
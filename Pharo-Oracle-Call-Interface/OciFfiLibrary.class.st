Class {
	#name : #OciFfiLibrary,
	#superclass : #FFILibrary,
	#category : 'Pharo-Oracle-Call-Interface-UFFI'
}

{ #category : #initialization }
OciFfiLibrary class >> resetUniqueInstance [
	<script>
	uniqueInstance := nil
]

{ #category : #'library path' }
OciFfiLibrary >> ffiLibraryName [
	^ 'oci.dll'
]

{ #category : #'accessing - platform' }
OciFfiLibrary >> macLibraryName [
	^ 'libclntsh.dylib'
]

{ #category : #'library path' }
OciFfiLibrary >> win32ModuleName [
	^ 'oci.dll'
]

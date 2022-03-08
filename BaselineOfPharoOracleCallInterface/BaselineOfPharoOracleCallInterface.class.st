"
I am BaselineOfPharoOracleCallInterface.

I load the Pharo-Oracle-Call-Interface project, a binding with Oracle's OCI using FFI.

https://github.com/Ironirc/Pharo-Oracle-Call-Interface
"
Class {
	#name : #BaselineOfPharoOracleCallInterface,
	#superclass : #BaselineOf,
	#category : 'BaselineOfPharoOracleCallInterface'
}

{ #category : #baselines }
BaselineOfPharoOracleCallInterface >> baseline: spec [
	<baseline> 
	
	spec for: #common do: [
		spec 
			package: 'Pharo-Oracle-Call-Interface';
			group: 'default' with: #('Pharo-Oracle-Call-Interface') ]
]

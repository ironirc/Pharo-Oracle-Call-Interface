"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPharoOracleCallInterface,
	#superclass : #PackageManifest,
	#category : 'Pharo-Oracle-Call-Interface-Manifest'
}

{ #category : #'code-critics' }
ManifestPharoOracleCallInterface class >> ruleBadMessageRule2V1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#OciBindingByName #getValueFromInput: #false)) #'2022-02-26T15:57:33.14+01:00') )
]

{ #category : #'code-critics' }
ManifestPharoOracleCallInterface class >> ruleUncommonMessageSendRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'Pharo-Oracle-Call-Interface')) #'2022-02-26T15:57:07.124+01:00') )
]

accessing
factory
	^ factory ifNil: [ factory := [ self error: 'Please set a factory to create a configured OciClient instance' ] ]
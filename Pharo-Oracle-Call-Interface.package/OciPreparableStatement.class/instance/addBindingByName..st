private
addBindingByName: aName

	| binding |
	binding := OciBindingByName new
		           name: aName;
		           statement: self.
	bindings add: binding.
	^binding
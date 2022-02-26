private
addBindingByPosition: aPosition

	| binding |
	binding := OciBindingByPosition new
		           position: aPosition;
		           statement: self.
	bindings add: binding.
	^ binding
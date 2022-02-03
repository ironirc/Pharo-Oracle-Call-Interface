printing
fullDescription
	^ String streamContents: [ :ws | ws << self code displayString << ' - ' << self description ]
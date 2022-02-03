*Pharo-Oracle-Call-Interface
decodedFromOciDate
	^ DateAndTime
		year: ((self at: 1) - 100) * 100 + ((self at: 2) - 100)
		month: (self at: 3)
		day: (self at: 4)
		hour: (self at: 5) - 1
		minute: (self at: 6) - 1
		second: (self at: 7) - 1
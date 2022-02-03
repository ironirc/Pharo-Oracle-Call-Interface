test
rowValueArrayForRow: rowIndex
	^ self rowBuffers collect: [ :rb | rb valueAtRow: rowIndex ]
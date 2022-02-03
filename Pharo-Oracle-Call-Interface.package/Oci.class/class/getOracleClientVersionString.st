public
getOracleClientVersionString
"
self getOracleClientVersionString inspect
"
	| major_version minor_version update_num patch_num port_update_num ma mi |
	major_version := ExternalAddress newPointer autoRelease.
	minor_version := ExternalAddress newPointer autoRelease.
	update_num := ExternalAddress newPointer autoRelease.
	patch_num := ExternalAddress newPointer autoRelease.
	port_update_num := ExternalAddress newPointer autoRelease.
	self
		OCIClientVersion: major_version
		minor_version: minor_version
		update_num: update_num
		patch_num: patch_num
		port_update_num: port_update_num.
	ma := major_version signedShortAt: 1.
	mi := minor_version signedShortAt: 1.
	^ String streamContents: [ :ws | ws << 'Oracle ' << ma printString << 'G release' << mi printString ]
ffi-calls
OCIClientVersion: major_version minor_version: minor_version update_num: update_num patch_num: patch_num port_update_num: port_update_num
"
void OCIClientVersion ( sword *major_version,
 sword *minor_version,
 sword *update_num,
 sword *patch_num,
 sword *port_update_num );
"

	^ self
		ffiCall:
			#(short OCIClientVersion #(sword * major_version , sword * minor_version , sword * update_num , sword * patch_num , sword * port_update_num))
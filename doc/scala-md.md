
### Scala Markdown Test



	#!/bin/bash
	
	# Do some stuff here
	USER_CLASSPATH="/path/to/lib.jar:/path/to/class/folder"
	
	# Call scala here (script.location is passed as property because it is often very useful)
	script=${0}
	exec scala -classpath "${USER_CLASSPATH}" -Dscript.location=$(dirname ${script}) $script "$@"
	!#
	
	


Something else:

	var t = ""


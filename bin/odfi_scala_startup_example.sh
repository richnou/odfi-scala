#!/usr/bin/env scala_script


var scriptLocation = sys.props("script.location")

// Go Gen
//-----------------
println(s"This script is located in ${scriptLocation}")
args.foreach { a => println(s"This is an argument $a")	 }
#!/bin/sh
exec scala "$0" "$@"
!#

/*object HelloWorld2 extends Application {
	
  println("This is an embedded scala script")
 println("We will be runnning a process: ")

	/*foreach( a <- args) {
				println(s"This is an argument $a")	
		
	}*/
	
	args.foreach { a => println(s"This is an argument $a")	 }

}
HelloWorld2.main(args)*/

println("This is an embedded scala script")
 println("We will be runnning a process: ")
args.foreach { a => println(s"This is an argument $a")	 }
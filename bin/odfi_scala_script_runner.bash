#!/bin/bash
script=${0}
exec scala -Dlocation=$(dirname ${script}) "$0" "$@"
!#

/*
WARNING: THIS CODE IS NOT CLEANED BECAUSE IT MESSED AROUND WITH THE IMain/ScriptRunner usage
It still don't know it the IMain usage is correct, so I'll clean this mess
when somebody has confirmed/infirmed the implementation

For now the implementation is not really functional, because if a script
augments the classpath, IMain is replaced and all the following executions
will start with the augmented classpath

This will be fixed when concept is validated

*/


import scala.Console
import java.io._
import java.net._
import scala.io._
import scala.tools.nsc._
import scala.tools.nsc.interpreter._
import akka.actor.ActorSystem
import akka.actor.Actor
import akka.actor.ActorLogging
import akka.actor.Props
import akka.event.Logging


var settings = new GenericRunnerSettings({
		error => println(error)
})
var imain = new IMain(settings)	

class scriptrunner extends Actor with ActorLogging {

	
	
	def runScript (socket : Socket) = {
	
					
		try {
			// Get All lines
			var lines = Source.fromInputStream(socket.getInputStream()).getLines
			
			// Line 1 = arguments
			// Line 2 = caller pty
			// Line 3 = script location
			// Remaining = script
			// ---------------------------
			var args = lines.take(1).mkString.split(" ")
			var pty = lines.take(1).mkString.trim
			var scriptLocation = lines.take(1).mkString.trim
			var completeScript = lines.mkString("\n")
			
			//log.debug(s"Complete string: ${lines.mkString("\n")}")
			
			// Prepare args
			//------------------
			
		
			// Open PTY
			// ------------------
			var pout = new java.io.PrintStream(pty)
			
			// Divide Script into sections and run them
			// --------------------------------------
			var runScript = ""
			var count = 0		
			completeScript.split(";--").foreach {
				scriptSection =>
				
				count+=1
				// wrap script in object
				var script = s"""
					
					object sect$count { 
						var scriptLocation = "$scriptLocation"
						
						def run = {
							//  $scriptSection 
						}
					}
					
					
				"""
				//println(s"Running script section: \n $script")
				
				
				// Run with output to user terminal
				//-------------------------------
				Console.withOut(pout) {
					Console.withErr(pout) {
					
						// -- JUNK HERE
						/*var main = new IMain()
						main.bind("args",args)
						main.bind("scriptLocation",scriptLocation)
						main.interpret(script)*/
						
						//interpret(line: String)
						//$scriptLocation
						//main.interpret("println(s\"Section 2 is setting classpath at: $scriptLocation , on ${Thread.currentThread.getContextClassLoader}\");");
						//println(s"Interpreting: \n $script")
						
						//-------------------
						
						//-- Compile && interpret if successful
						imain.compileString(script) match {
							case true => imain.interpret(s"sect${count}.run")
							case false => throw new RuntimeException("A section run failed")
						}
						
						// -- JUNK HERE
						//runScript += s"sect${count}.run\n"
						//imain.interpret(s"sect${count}.run")
						
						//main.main()
						//main.quietRun[Unit](script)
						//script.split("\n").foreach(main.compileString(_))
						
						
						// Run script
						/*ScriptRunner.runCommand(
							settings, 
							script, 
							List[String](s"$scriptLocation") ++ args.toList)*/
						//-------------------
						
					}
				} // EOF run script
				
				//println(s"After Script Th classloader ${Thread.currentThread.getContextClassLoader}");
				//main.setContextClassLoader
				if (classOf[java.net.URLClassLoader].isAssignableFrom(Thread.currentThread.getContextClassLoader.getClass)) {
				
					println("URL classloader found")
					
					Thread.currentThread.getContextClassLoader.asInstanceOf[java.net.URLClassLoader].getURLs.foreach {
						url => 
							println(s"Augmenting classpath: $url");
							settings.classpath.value+= s"$url"
							//imain.compilerClasspath +:: Seq[URL](url)
							//main.compilerClasspath = Seq[URL](url,main.compilerClasspath);
							//main.compilerClasspath = Seq[URL](url);
					}
					//println(s"Settings CP: ${settings.classpath}");
					//imain.reset
					//imain.resetClassLoader
					//imain.initializeSynchronous
					imain.close
					pout.close
					
					pout = new java.io.PrintStream(pty)
					imain = new IMain(settings)
					
					println(s"After script CC classpath ${imain.compilerClasspath}");
				
				}
				
			}
			
			//println("Done");
			
		
		}  catch {
			case e: RuntimeException =>
		} finally {
			socket.close()
		}
		
	
	}

	def receive = {
	
		case socket : Socket => {
			
			
			runScript {socket}
			
			
		}
	}
}


// Script Runner daemon
//  - Opens a unix socket in env("ODFI_DEV_SCALA_HOME")/script_runner.unix
//  -
//--------------------------------
var scriptLocation = sys.props("location")
//println("Welcome to Scala Script runner daemon");
//println("Script runner daemon source is located at "+scriptLocation);

//--------------------------------------------------------
// Should we open a network connection?

var runnerSocket = new ServerSocket(20000, 10)
//var runnerSocket = DatagramSocket(20000)
//----------------------------

//-- Start runner
val system = ActorSystem("ScriptRunnerSystem")
val dispatcher = system.actorOf(Props( new scriptrunner), name = "scriptrunner")


//-- Accept connections
println("Ready");
while (true) {
	//println("Ready");
	var connection = runnerSocket.accept()	
	//println("Dispatching connection");


	dispatcher ! connection 
}




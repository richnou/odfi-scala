#!/usr/bin/env scala_daemon_script


//var scriptLocation = args.take(1).mkString
println(s"Section 0 at: $scriptLocation, on ${Thread.currentThread.getContextClassLoader}");


;-- Section 2

import java.net._
import java.io.File

//var scriptLocation = args.take(1).mkString
var path = new File(scriptLocation+"/../scala-preload/junixsocket-1.3.jar")
Thread.currentThread.setContextClassLoader(new URLClassLoader(Array[URL](path.toURI.toURL),Thread.currentThread.getContextClassLoader()))

println(s"Section 2 is setting classpath at: $scriptLocation, on ${Thread.currentThread.getContextClassLoader}");



;-- Section 1

//var scriptLocation = args.take(1).mkString
println(s"Section 1 at: $scriptLocation, on ${Thread.currentThread.getContextClassLoader}");



;-- Section main

import org.newsclub.net.unix.AFUNIXSocket;
import org.newsclub.net.unix.AFUNIXSocketAddress;
import org.newsclub.net.unix.AFUNIXSocketException;

//var scriptLocation = args.take(1).mkString
println("This script is compiled/run by the script runner daemon");
println(s"It is located at: $scriptLocation ");

/*
args.foreach {
		arg => println(s"argument: $arg")	
}
*/

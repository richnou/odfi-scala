#!/usr/bin/env scala_daemon_script

//var scriptLocation = args.take(1).mkString
println("This script is compiled/run by the script runner daemon");
println(s"It is located at: $scriptLocation ");


var  runtime = java.lang.management.ManagementFactory.getRuntimeMXBean();
var jvm = runtime.getClass().getDeclaredField("jvm");
jvm.setAccessible(true);
var mgmt = jvm.get(runtime).asInstanceOf[sun.management.VMManagement];
var pid_method = mgmt.getClass().getDeclaredMethod("getProcessId");
pid_method.setAccessible(true);
var pid = pid_method.invoke(mgmt).asInstanceOf[Integer];

println("PID is: "+pid)

//args.foreach {
		//		arg => println(s"argument: $arg")	
//}
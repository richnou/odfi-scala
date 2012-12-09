#!/usr/bin/env scala_script


_SCALA_PRELOAD_
#!/usr/bin/env scala

println("This is a scala Bootstrap");

_EOF_SCALA_PRELOAD_

println("This is scala here")
args.foreach ( arg => println(s"Argument: "+arg))

var  runtime = java.lang.management.ManagementFactory.getRuntimeMXBean();
var jvm = runtime.getClass().getDeclaredField("jvm");
jvm.setAccessible(true);
var mgmt = jvm.get(runtime).asInstanceOf[sun.management.VMManagement];
var pid_method = mgmt.getClass().getDeclaredMethod("getProcessId");
pid_method.setAccessible(true);
var pid = pid_method.invoke(mgmt).asInstanceOf[Integer];

println("PID is: "+pid)

#!/usr/bin/env scala_script_preload

_SCALA_PRELOAD_

import java.net._
import java.io.File

var path = new File("/home/rleys/git/odfi/modules/dev/scala/examples/scala-preload/junixsocket-1.3.jar")
Thread.currentThread.setContextClassLoader(URLClassLoader.newInstance(Array[URL](path.toURI.toURL),Thread.currentThread.getContextClassLoader()))

println("Bootstrap :"+Thread.currentThread.getContextClassLoader())

_EOF_SCALA_PRELOAD_
  
import org.newsclub.net.unix.AFUNIXSocket;
import org.newsclub.net.unix.AFUNIXSocketAddress;
import org.newsclub.net.unix.AFUNIXSocketException;


println("This is scala here"+Thread.currentThread.getContextClassLoader())



#!/usr/bin/env scala_script

_SCALA_PRELOAD_


echo "${SCRIPT_LOCATION}/../scala-preload/junixsocket-1.3.jar"

_EOF_SCALA_PRELOAD_
  
import org.newsclub.net.unix.AFUNIXSocket;
import org.newsclub.net.unix.AFUNIXSocketAddress;
import org.newsclub.net.unix.AFUNIXSocketException;


println("This is scala here"+Thread.currentThread.getContextClassLoader())



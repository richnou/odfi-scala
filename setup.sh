#!/bin/bash


loc="$(dirname "$(readlink -f ${BASH_SOURCE[0]})")"

## Setup Scala if present
#############################
scalaPath="$loc/external/scala-2.10.0-RC2"
#echo "Looking for scala at: $scalaPath" 
if [[ -d $scalaPath ]]
then
	
	#echo "Found scala install at $scalaPath, using it"
	export SCALA_HOME=$scalaPath
	export PATH=$scalaPath/bin:$PATH
	export LD_LIBRARY_PATH=$scalaPath/lib:$LD_LIBRARY_PATH
	#mandb -uq $scalaPath/man/
fi


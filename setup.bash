#!/bin/bash


loc="$(dirname "$(readlink -f ${BASH_SOURCE[0]})")"
export ODFI_DEV_SCALA_HOME=$loc
SCALA_VERSION="scala-2.10.0-RC3"


## Setup Scala if present
#############################
scalaPath="$loc/external/${SCALA_VERSION}"
#echo "Looking for scala at: $scalaPath" 

## If no scala install detected, setup the module
if [[ ! -d ${scalaPath} ]]
then
	
	echo "No Scala local install detected, setting up"
	SCALA_VERSION=${SCALA_VERSION} make -C $loc/external odfi_setup
	
fi

if [[ -d $scalaPath ]]
then
	
	#echo "Found scala install at $scalaPath, using it"
	export SCALA_HOME=$scalaPath
	export PATH=$scalaPath/bin:$PATH
	export LD_LIBRARY_PATH=$scalaPath/lib:$LD_LIBRARY_PATH
	#mandb -uq $scalaPath/man/
fi

## Setup ourselves if in standalone modus
if [[ ! -n ${ODFI_MANAGED} ]]
then
	export PATH="$loc/bin:$PATH"
fi

#!/bin/bash


loc="$(dirname "$(readlink -f ${BASH_SOURCE[0]})")"
export ODFI_DEV_SCALA_HOME=$loc
export SCALA_VERSION="2.10.1"


## Setup Scala if present
#############################
scalaPath="$loc/external/scala-${SCALA_VERSION}"
#echo "Looking for scala at: $scalaPath"

## If no scala install detected, setup the module
if [[ ! -d ${scalaPath} ]]
then

	echo "No Scala local install detected, setting up"
	SCALA_VERSION=${SCALA_VERSION} make -C $loc/external scala

fi

if [[ -d $scalaPath ]]
then

	#echo "Found scala install at $scalaPath, using it"
	export SCALA_HOME=$scalaPath
	export PATH=$scalaPath/bin:$PATH
	export LD_LIBRARY_PATH="$scalaPath/lib:$LD_LIBRARY_PATH"
	#mandb -uq $scalaPath/man/
fi

## Setup SBT
###################
SBT_VERSION="0.12.3"
sbtPath="$loc/external/sbt-${SBT_VERSION}"
sbtCustomPath="$loc/external/sbt-custom"
if [[ ! -f ${sbtPath}/sbt ]]
then

	echo "No SBT local install detected, setting up version ${SBT_VERSION}"
	SBT_VERSION=${SBT_VERSION} make -C $loc/external sbt
fi

if [[ -f ${sbtCustomPath}/sbt-custom ]]
then


	export PATH=$sbtCustomPath/:$PATH

elif [[ -d $sbtPath ]]
then
	export PATH=$sbtPath/:$PATH
fi


## Setup ourselves if in standalone modus
###################
if [[ ! -n ${ODFI_MANAGED} ]]
then
	export PATH="$loc/bin:$PATH"
fi

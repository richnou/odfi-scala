

## Expected Scala version (provided by setup.sh for now normaly)
#SCALA_VERSION ?= scala-2.10.0-RC3

SCALA_VERSION ?= 2.10.1
SBT_VERSION   ?= 0.12.3

## If no scala bin, download from scala website
odfi_setup: scala sbt

scala: scala-$(SCALA_VERSION)/bin/scala
scala-$(SCALA_VERSION)/bin/scala: scala-$(SCALA_VERSION).tgz
	@tar xvaf scala-$(SCALA_VERSION).tgz
scala-$(SCALA_VERSION).tgz:
	@echo "Downloading scala using wget and unpacking"
	@wget http://www.scala-lang.org/downloads/distrib/files/scala-$(SCALA_VERSION).tgz


sbt: sbt-$(SBT_VERSION)/sbt sbt-$(SBT_VERSION)/sbt-launch.jar
sbt-$(SBT_VERSION)/sbt-launch.jar:
	@echo "Getting SBT version tag: $(SBT_VERSION)"
	@cd sbt-$(SBT_VERSION)/ && wget http://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/${SBT_VERSION}/sbt-launch.jar


sbt-$(SBT_VERSION)/sbt:
	@mkdir -p sbt-$(SBT_VERSION) && cp sbt sbt-$(SBT_VERSION)/sbt
	@chmod +x sbt-$(SBT_VERSION)/sbt

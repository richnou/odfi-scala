

## Expected Scala version (provided by setup.sh for now normaly)
SCALA_VERSION ?= scala-2.10.0-RC3

## If no scala bin, download from scala website
odfi_setup: $(SCALA_VERSION)/bin/scala
$(SCALA_VERSION)/bin/scala: $(SCALA_VERSION).tar.gz
$(SCALA_VERSION).tar.gz:
	@echo "Downloading scala using wget and unpacking"
	@wget http://www.scala-lang.org/downloads/distrib/files/$(SCALA_VERSION).tgz
	@tar xvaf $(SCALA_VERSION).tgz
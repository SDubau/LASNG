#!/bin/bash

if [ -z "$1" ]
  then echo The instance base is missing [eg. ./createjavaopt.sh /opt/LAS/domains/test/core/conf]
else

INSTANCE_BASE=$1

echo Please enter the JAVA_OPTS settings [Default: -server -Xmn1024m -Xmx2048m -Xincgc]
read answer

if [ -z $answer ]
then echo "export JAVA_OPTS='-server -Xmn1024m -Xmx2048m -Xincgc'" > $INSTANCE_BASE/javaopts.settings
else
echo "export JAVA_OPTS='$answer'" > $INSTANCE_BASE/javaopts.settings
fi

echo OK.

fi


#!/bin/bash

JAVA_OPTS="-server -Xmn64m -Xmx128m -Xincgc"
export JAVA_OPTS

case "$1" in

start)
echo ==========================
echo Starting tcore
echo ==========================
$LAS_HOME/tcore/bin/startup.sh
;;

stop)
echo ==========================
echo Stoping tcore
echo ==========================
$LAS_HOME/tcore/bin/shutdown.sh
;;
*)
echo $"Usage: $0 {start|stop}"
esac



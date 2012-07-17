#!/bin/bash
if [ -z "$1" -o -z "$2" -o -z "$3" -o -z "$3" ]
  then echo Usage $0 {Domain name} {Instance name} {start/stop}
else

source $LAS_HOME/domains/$1/$2/conf/javaopts.settings

export CATALINA_BASE=$LAS_HOME/domains/$1/$2
export CATALINA_HOME=$LAS_HOME/tcore

case "$3" in
start)
echo ==========================
echo Starting $1/$2
echo ==========================
$CATALINA_HOME/bin/catalina.sh start
ps axf | grep $1/$2 | grep -v grep |awk '{print $1}' > $CATALINA_BASE/conf/catalina.pid
echo "OK"
;;
stop)
echo ==========================
echo Stoping $1/$2
echo ==========================
export CATALINA_PID=$CATALINA_BASE/conf/catalina.pid
$CATALINA_HOME/bin/catalina.sh stop -force
echo "OK"
;;
*)
echo $"$3 is not a valid command"
esac
fi

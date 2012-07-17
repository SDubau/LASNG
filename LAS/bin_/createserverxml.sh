#!/bin/bash
if [ -z "$1" -o -z "$2" -o -z "$3" ]
  then echo The port/path to server.xml is missing [eg. ./createserverxml.sh 8300 TestDomain core]
else

serverport=$1
shutport=$(($1+5))
ajpport=$(($1+9))

PATH_TO_XML=$LAS_HOME/domains/$2/$3/conf

sed -i 's/<Server port=\"8005\" shutdown=\"SHUTDOWN\">/<Server port=\"'$shutport'\" shutdown=\"SHUTDOWN\">/g' $PATH_TO_XML/server.xml
sed -i 's/<Connector port=\"8080\" protocol=\"HTTP\/1.1\"/<Connector port=\"'$serverport'\" protocol=\"HTTP\/1.1\"/g' $PATH_TO_XML/server.xml
sed -i 's/<Connector port=\"8009\" protocol=\"AJP\/1.3\" redirectPort=\"8443\" \/>/<Connector port=\"'$ajpport'\" protocol=\"AJP\/1.3\" redirectPort=\"8443\" \/>/g' $PATH_TO_XML/server.xml

echo "$serverport $2/$3/con" >> $LAS_HOME/conf/usedports.settings
echo "$ajpport $2/$3/ajp" >> $LAS_HOME/conf/usedports.settings
echo "$shutport $2/$3/shu" >> $LAS_HOME/conf/usedports.settings

echo OK.

fi

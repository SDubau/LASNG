#!/bin/bash
clear
if [ -z "$1" ]
  then echo The domain name is missing [eg. ./createdomain.sh Test-System]
else

echo ========================== 
echo comosoft Domain-Installer
echo ==========================
echo Install prerequirements
echo --------------------------

# Erstellung der Domain-Verzeichnisse und export der DOMAIN_HOME Variable

mkdir $LAS_HOME/domains/$1
export DOMAIN_HOME=$LAS_HOME/domains/$1

mkdir $LAS_HOME/logs/$1
mkdir $LAS_HOME/logs/$1/rdb
mkdir $LAS_HOME/logs/$1/lfs
mkdir $LAS_HOME/logs/$1/lws
mkdir $LAS_HOME/logs/$1/lmb

mkdir $LAS_HOME/temp/$1
mkdir $LAS_HOME/temp/$1/lws

# Kopieren der Instanzen in diese Domain

cp -R $LAS_HOME/template/instance/ $DOMAIN_HOME/core
cp -R $LAS_HOME/template/instance/ $DOMAIN_HOME/lws
cp -R $LAS_HOME/template/instance/ $DOMAIN_HOME/web

echo
echo Done.
echo
echo --------------------------
echo Install instances
echo --------------------------
echo
echo "The domain consists of multiple instances (core/lws/web). These instances require internal ports to be able to communicate with each other."
echo "The ports can be freely defined."
echo
echo --------------------------
echo Setup core
echo --------------------------
echo

# Einlesen der gesperrten Ports und Ueberpruefung des eingegebenen Ports

filearray=(`cat $LAS_HOME/conf/usedports.settings | awk '{print $1}'`)

cont=true

while [ $cont == true ]
do
cont=false
read -p "Please enter the port for core : " port
for E in ${filearray[@]}
do      if [ "$port" == "$E" ]
        then
        echo "Port is invalid"
        cont=true
        fi
done
done

# Ist der Port ok, so wird die server.xml erstellt

$LAS_HOME/bin/createserverxml.sh $port $1 core

# Erstellung der JAVA_OPTS

$LAS_HOME/bin/createjavaopts.sh $DOMAIN_HOME/core/conf
echo
echo --------------------------
echo Setup lws
echo --------------------------
echo
# Einlesen der gesperrten Ports und Ueberpruefung des eingegebenen Ports

filearray=(`cat $LAS_HOME/conf/usedports.settings | awk '{print $1}'`)

cont=true

while [ $cont == true ]
do
cont=false
read -p "Please enter the port for lws : " port
for E in ${filearray[@]}
do      if [ "$port" == "$E" ]
        then
        echo "Port is invalid"
        cont=true
        fi
done
done

# Ist der Port ok, so wird die server.xml erstellt

$LAS_HOME/bin/createserverxml.sh $port $1 lws

# Erstellung der JAVA_OPTS

$LAS_HOME/bin/createjavaopts.sh $DOMAIN_HOME/lws/conf
echo
echo --------------------------
echo Setup web
echo --------------------------
echo
filearray=(`cat $LAS_HOME/conf/usedports.settings | awk '{print $1}'`)

cont=true

while [ $cont == true ]
do
cont=false
read -p "Please enter the port for web : " port
for E in ${filearray[@]}
do      if [ "$port" == "$E" ]
        then
        echo "Port is invalid"
        cont=true
        fi
done
done

$LAS_HOME/bin/createserverxml.sh $port $1 web
$LAS_HOME/bin/createjavaopts.sh $DOMAIN_HOME/web/conf

# Abfrage ob die Instanzen gestartet werden sollen

echo "Start core/lws/web (y/n)?"
read startan
if [ "$startan" == "n" ]
 then echo "You can start your instances via control.sh ( $LAS_HOME/bin/control.sh {Domainname} {Instancename} {start/stop} "
else 
$LAS_HOME/bin/control.sh $1 core start
sleep 5
$LAS_HOME/bin/control.sh $1 lws start
sleep 5
$LAS_HOME/bin/control.sh $1 web start
sleep 5
fi
fi

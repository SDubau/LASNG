#!/bin/bash
if [ -z "$1" ]
  then echo The installation path is missing [eg. ./install.sh /opt]
else

echo ==========================
echo comosoft LAS-Installer
echo ========================== 
echo Install prerequirements
echo -------------------------- 

# entpacke die LAS.tar

tar xfv $1/LAS.tar -C $1

# fuehre die java-installer.bin aus und erstelle einen Simlink von diesesm Verzeichnis

chmod +x $1/LAS/java-installer.bin
cd $1/LAS
$1/LAS/java-installer.bin
jdk=$(ls | grep jdk)
ln -s $jdk java

echo
echo --------------------------
echo Create folder structure
echo --------------------------
echo

# erstelle die Verzeichnisse temp/logs/LagoFS

mkdir $1/LAS/temp

mkdir $1/LAS/logs

mkdir $1/LAS/LagoFS

echo Done.

echo
echo --------------------------
echo Create environment
echo --------------------------
echo

# fuege JAVA_HOME und LAS_HOME als Umgebungsvariable hinzu

echo "export JAVA_HOME=$1/LAS/java" >> ~/.bashrc
echo "export LAS_HOME=$1/LAS" >> ~/.bashrc

export JAVA_HOME=$1/LAS/java
export LAS_HOME=$1/LAS

# fuege die general.setting in die httpd.conf hinzu

echo "In the WebServer.conf file it is necessary to set certain variables.  Please enter you Account password when prompted."
sudo sh -c "echo Include $LAS_HOME/conf/general.settings >> /etc/httpd/conf/httpd.conf"

# fuege den Pfad fuer die proxy.settings in die general.settings ein

echo "Include $LAS_HOME/conf/proxy.settings" >> $LAS_HOME/conf/general.settings

# Abfrage nach dem Apache-Port, um den Port sperren zu lassen

echo "For which port is the WebServer configured?"
read port
echo "$port apache" >> $LAS_HOME/conf/usedports.settings

# Ports fuer den Tcore sperren lassen

echo "8080 tcore" >> $LAS_HOME/conf/usedports.settings
echo "8005 tcore" >> $LAS_HOME/conf/usedports.settings
echo "8009 tcore" >> $LAS_HOME/conf/usedports.settings

# kopiere die LagoApplications.properties in das lib-Verzeichnis von tcore, damit alle Instanzen diese Datei besitzen

mv $1/LagoApplications.properties $LAS_HOME/tcore/lib/

# starten des tcores

chmod -R +x $1/LAS/tcore/bin/*.sh
$LAS_HOME/bin/tcore.sh start
sleep 5
echo Done.

echo Restart Web-Server
/etc/init.d/httpd reload

# Abfrage ob eine Domain ertstellt werden soll

echo --------------------------
echo Would you like to create a domain? {y/n}
read create

if [ $create == "n" ]
	then echo "It is possible to configure the domain at a later point, it is then necessary to login once again, so that the Environment can be set."
else

echo "What is the name of the domain?"
read dom
$LAS_HOME/bin/createdomain.sh $dom
fi
fi

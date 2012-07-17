#!/bin/bash
clear
echo ===============================
echo comosoft Domain-Deinstaller
echo ===============================

filearray=( `ls $LAS_HOME/domains`)

echo Please select the domain
echo -------------------------------
for (( i=0; i<${#filearray[@]}; i++));
do
echo [$i] ${filearray[$i]}
echo -------------------------------
done

k=1
while [ $k = 1 ]
do
        k=0
        read -p "Number: " answer
        if [ -z "${filearray[$answer]}" -o -z "$answer" ]
                then echo Number is invalid
                k=1
        fi
done

rm -rf $LAS_HOME/domains/${filearray[$answer]}
rm -rf $LAS_HOME/temp/${filearray[$answer]}
rm -rf $LAS_HOME/logs/${filearray[$answer]}

cp $LAS_HOME/conf/usedports.settings $LAS_HOME/conf/usedports_org.settings
grep -v ${filearray[$answer]} $LAS_HOME/conf/usedports_org.settings > $LAS_HOME/conf/usedports.settings
rm -rf $LAS_HOME/conf/usedports_org.settings

echo Done.

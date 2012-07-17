#!/bin/bash
clear

if [ -z "$1" -o -z "$2" -o -z "$3" ]
then
echo ===============================
echo The Lago-Servlet-Installer
echo ===============================
echo [1] Install Servlet
echo [2] Update Servlet
echo [3] Delete Servlet
echo -------------------------------

k=1
while [ $k = 1 ]
do
        k=0
        read -p "Number: " action
        if [ "$action" -gt "3" -o -z "$action" -o "$action" -lt "1" ]
                then echo Number is invalid
                k=1
        fi
done

echo 
echo -------------------------------
echo Please select the domain
echo -------------------------------
domainarray=( `ls $LAS_HOME/domains`)
for (( i=0; i<${#domainarray[@]}; i++));
do
echo [$i] ${domainarray[$i]}
done
echo -------------------------------


k=1
while [ $k = 1 ]
do
        k=0
        read -p "Number: " domain
        if [ -z "${domainarray[$domain]}" -o -z "$domain" ]
                then echo Number is invalid
                k=1
        fi
done



echo
echo -------------------------------
echo Please select the instance
echo -------------------------------
instancearray=( `ls $LAS_HOME/domains/${domainarray[$domain]}`)
for (( i=0; i<${#instancearray[@]}; i++));
do
echo [$i] ${instancearray[$i]}
done
echo -------------------------------

k=1
while [ $k = 1 ]
do
        k=0
        read -p "Number: " instance
        if [ -z "${instancearray[$instance]}" -o -z "$instance" ]
                then echo Number is invalid
                k=1
        fi
done

echo "You have selected ${domainarray[$domain]} and ${instancearray[$instance]}"

else
echo "You have selected $1 $2 $3"
fi


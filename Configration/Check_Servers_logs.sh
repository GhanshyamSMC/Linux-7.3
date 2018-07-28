#!/bin/sh
TIMESTAMP=`date "+%Y-%m-%d"`


echo S1101
echo "****************************"
cd /honey/FO_Server11_1/
var="$(cat version.txt)"
cd="$var/server/log"
cd $cd 
grep -i -e "Down stream is ready" -e "server is ready" -e "Connected with Exchange" -e "Connecting to NSE Downstream server" server$TIMESTAMP.log

echo S1102
echo "****************************"
cd /honey/FO_Server11_2/
var="$(cat version.txt)"
cd="$var/server/log"
cd $cd 
grep -i -e "Down stream is ready" -e "server is ready" -e "Connected with Exchange" -e "Connecting to NSE Downstream server" server$TIMESTAMP.log

echo S1103
echo "****************************"
cd /honey/FO_Server11_3/
var="$(cat version.txt)"
cd="$var/server/log"
cd $cd 
grep -i -e "Down stream is ready" -e "server is ready" -e "Connected with Exchange" -e "Connecting to NSE Downstream server" server$TIMESTAMP.log

echo S1104
echo "****************************"
cd /honey/FO_Server11_4/
var="$(cat version.txt)"
cd="$var/server/log"
cd $cd 
grep -i -e "Down stream is ready" -e "server is ready" -e "Connected with Exchange" -e "Connecting to NSE Downstream server" server$TIMESTAMP.log


echo S1109
echo "****************************"
cd /honey/FO_Server11_9/
var="$(cat version.txt)"
cd="$var/server/log"
cd $cd 
grep -i -e "Down stream is ready" -e "server is ready" -e "Connected with Exchange" -e "Connecting to NSE Downstream server" server$TIMESTAMP.log

echo S1110
echo "****************************"
cd /honey/FO_Server11_10/
var="$(cat version.txt)"
cd="$var/server/log"
cd $cd 
grep -i -e "Down stream is ready" -e "server is ready" -e "Connected with Exchange" -e "Connecting to NSE Downstream server" server$TIMESTAMP.log

echo S1111
echo "****************************"
cd /honey/FO_Server11_11/
var="$(cat version.txt)"
cd="$var/server/log"
cd $cd 
grep -i -e "Down stream is ready" -e "server is ready" -e "Connected with Exchange" -e "Connecting to NSE Downstream server" server$TIMESTAMP.log





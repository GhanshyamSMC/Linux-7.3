#!/bin/sh
TIMESTAMP=`date "+%Y-%m-%d"`

echo OMSS1100
echo "********************************"

cd /honey/FO_OMS11_1/
var="$(cat version.txt)"
cd="$var/server/log"
cd $cd 
grep -i -e "Connecting to NSE Downstream server" -e "Login is complete" -e "unhandled transaction code recieved:2" server$TIMESTAMP.log

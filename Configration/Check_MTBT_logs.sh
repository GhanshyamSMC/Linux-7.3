#!/bin/sh
TIMESTAMP=`date "+%Y-%m-%d"`

echo MTBT_NIFTY_S1100
echo "****************************"
cd /honey/FO_MTBT_11_1/
var="$(cat version.txt)"
cd="$var/server/log"
cd $cd 
grep -i -e "In MTBTAdaptor init" -e "initialising" -e "Connected with NSE FO MTBT" server$TIMESTAMP.log

echo MTBT_BANKNIFTY_S1100
echo "****************************"
cd /honey/FO_MTBT11_1/
var="$(cat version.txt)"
cd="$var/server/log"
cd $cd 
grep -i -e "In MTBTAdaptor init" -e "initialising" -e "Connected with NSE FO MTBT" server$TIMESTAMP.log












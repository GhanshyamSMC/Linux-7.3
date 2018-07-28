#!/bin/sh
var="$(cat version.txt)"
echo version="$var"
cd="$var/server"
cd $cd
currentDir=$(pwd)/$cd
fileName=FO_MTBT7_1
mainClass=com.algo.adaptor.nse.md.MTBTAdapter
beansConfigFile=tbt.xml
dname=tbtbanknifty
echo currentDir=$currentDir filename=$fileName mainClass=$mainClass beansConfigFile=$beansConfigFile
export currentDir
export fileName
export mainClass
export beansConfigFile
export dname
./Common_Server.sh
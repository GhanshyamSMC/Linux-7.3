#!/bin/sh
var="$(cat version.txt)"
echo version="$var"
cd="$var/server"
cd $cd
currentDir=$(pwd)/$cd
fileName=FO_OMS7_1
mainClass=com.algo.adaptor.nse.oms.NseOMSServer
beansConfigFile=oms.xml
dname=oms7
echo currentDir=$currentDir filename=$fileName mainClass=$mainClass beansConfigFile=$beansConfigFile
export currentDir
export fileName
export mainClass
export beansConfigFile
export dname
./Common_Server.sh
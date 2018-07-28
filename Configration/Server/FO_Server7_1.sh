#!/bin/sh
var="$(cat version.txt)"
echo version="$var"
cd="$var/server"
cd $cd
currentDir=$(pwd)/$cd
fileName=FO_Server7_1
mainClass=com.algo.server.Server
beanConfigFile=server.xml
dname=s701
echo currentDir=$currentDir filename=$fileName mainClass=$mainClass beansConfigFile=$beansConfigFile
export currentDir
export fileName
export mainClass
export beansConfigFile
export dname
./Common_Server.sh

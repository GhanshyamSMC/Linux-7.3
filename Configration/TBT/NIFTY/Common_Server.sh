#!/bin/sh

if [ $mainClass == " " ] ; then
 	mainClass=com.algo.server.Server
	beanConfigFile=server.xml
fi
java  -ms256m -mx4096m -XX:PermSize=128m -XX:MaxPermSize=128 -Dbuild_dir=$buildDir -Dbuild_env=$fileName -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9002 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -cp jars/algo-server-2.35.jar $mainClass conf/$beanConfigFile -Dname=$dname
#/bin/sh

if [ $mainClass == " " ] ; then
 	mainClass=com.algo.server.Server
	beanConfigFile=server.xml
fi
java  -ms256m -mx4096m -XX:PermSize=128m -XX:MaxPermSize=128 -Dbuild_dir=$buildDir -Dbuild_env=$fileName  -cp jars/algo-server-2.35.jar $mainClass conf/$beanConfigFile -Dname=$dname

#!/bin/sh

set path=$PATH;
echo deployment started for: ip=$ip type=$type drive=$drive  dest=$dest description=$description
TIMESTAMP=`date "+%Y%m%d_%H%M%S"`
for f in tokens=2 delims == $a 
do
	echo "Processing $f"
	dt=$a
done
dtStamp=$TIMESTAMP
#:: Sets release directory from where build shall be copied to remote machine.
src=$releaseFrom
if [ $isServerDeployment == "true" ]; then
	#if ($releaseFrom != "" ); then
	#	 src=.\..\..\target\algo-server-2.35-build
	#else
	#	 src=$releaseFrom
	#fi

 	#rm logback-classic-1.1.2.jar and logback-core-1.1.2.jar . Use /p for prompting user 
	#before deletion e.g. del /p /s $src\server\jars\logback-classic-1.1.2.jar
#	echo /honey/deployment/server_release/latest/server/jars
#	rm $src\\server\\jars\\logback-classic-1.1.2.jar
	rm /honey/deployment/server_release/latest/server/jars/logback-classic-1.1.2.jar
	rm /honey/deployment/server_release/latest/server/jars/logback-core-1.1.2.jar
	echo deleted logback-classic-1.1.2.jar and logback-core-1.1.2.jar from server/jars
fi

#if "$isServerDeployment" == "true" (
#	if "$releaseFrom" == "" (SET src=.\..\..\target\algo-server-2.35-build) else (SET src=$releaseFrom)
#	:: Delete logback-classic-1.1.2.jar and logback-core-1.1.2.jar . Use /p for prompting user 
#	:: before deletion e.g. del /p /s %src%\server\jars\logback-classic-1.1.2.jar
#	del /s %src%\server\jars\logback-classic-1.1.2.jar
#	del /s %src%\server\jars\logback-core-1.1.2.jar
#	echo deleted logback-classic-1.1.2.jar and logback-core-1.1.2.jar from server/jars)   

echo src=$src releaseFrom=$releaseFrom isServerDeployment=$isServerDeployment dtStamp=$dtStamp
	
#Authenticates user on the deployment machine before starting copy and create a drive link.
#ssh \\$ip\$drive /user:$user $password
smbclient //172.17.0.46/c$ 123456 -U root
#Writes date time string with description of copy start.
echo Copying started at $date $time>>_date_.txt 

#Copies using robocopy. Always create a new directory.
#rsync /honey/deployment/server_release/latest/  #/MT:10 /NP /NFL /NDL /MIR /Z
#rsync -vaxrPXhn $releaseFrom $dest/V$dtStamp
scp -r $releaseFrom $dest/V$dtStamp
#Writes information including finished time to _date_.txt
echo Copying finished at $date $time>>_date_.txt 
echo Completed Successfully at $date $time>>_date_.txt 
echo --------------------------------------------------------------------------- >>_date_.txt 

#Install starts      --> Uses version.txt for maintaining server version.
rm $dest/version.txt
echo V$dtStamp>>$dest/version.txt
#Install ends

#Prints successfull message
echo deployment successfull. build is copied at $dest/V$dtStamp

#Removes directory link.
rm  y: /delete

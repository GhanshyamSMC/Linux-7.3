set path=c:\WINDOWS\system32; 

@echo off
echo deployment started for: ip=%ip% type=%type% drive=%drive%  dest=%dest% description=%description%

:: Sets the proper date and time stamp with 24Hr Time for directory naming convention
SET HOUR=%time:~0,2%
SET dtStamp9=%date:~-4%%date:~4,2%%date:~7,2%_0%time:~1,1%%time:~3,2%%time:~6,2% 
SET dtStamp24=%date:~-4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%
if "%HOUR:~0,1%" == " " (SET dtStamp=%dtStamp9%) else (SET dtStamp=%dtStamp24%)

echo %dtStamp%

:: Sets release directory from where build shall be copied to remote machine.
SET src=%releaseFrom%
if "%isServerDeployment%" == "true" (
	if "%releaseFrom%" == "" (SET src=.\..\..\target\algo-server-2.35-build) else (SET src=%releaseFrom%)
	:: Delete logback-classic-1.1.2.jar and logback-core-1.1.2.jar . Use /p for prompting user 
	:: before deletion e.g. del /p /s %src%\server\jars\logback-classic-1.1.2.jar
	del /s %src%\server\jars\logback-classic-1.1.2.jar
	del /s %src%\server\jars\logback-core-1.1.2.jar
	echo deleted logback-classic-1.1.2.jar and logback-core-1.1.2.jar from server/jars)   

echo src=%src%  releaseFrom=%releaseFrom% isServerDeployment=%isServerDeployment%
	
:: Authenticates user on the deployment machine before starting copy and create a drive link.
net use y: \\%ip%\%drive% /user:%user% %password%

:: Writes date time string with description of copy start.
echo Copying started at %date% %time%>>_date_.txt 

:: Copies using robocopy. Always create a new directory.
robocopy %src% y:%dest%\V%dtStamp% /MT:10 /NP /NFL /NDL /MIR /Z

:: Writes information including finishe time to _date_.txt
echo Copying finished at %date% %time%>>_date_.txt 
echo Completed Successfully at %date% %time%>>_date_.txt 
echo --------------------------------------------------------------------------- >>_date_.txt 

:: Install starts      --> Uses version.txt for maintaining server version.
del y:%dest%\version.txt
echo V%dtStamp%>>y:%dest%\version.txt
:: Install ends

:: Prints successfull message
echo deployment successfull. server is copied at %dest%\V%dtStamp%

:: Removes directory link.
net use y: /delete

pause
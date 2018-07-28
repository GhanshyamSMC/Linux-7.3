@echo off
set path=%PATH%;
echo deployment started for: ip=%ip% type=%type% drive=%drive%  dest=%dest% description=%description%
::Sets datetimestamp
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%" & set "HH=%dt:~8,2%" & set "MI=%dt:~10,2%" & set "SS=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" 
set "timestamp=%HH%%MI%%SS%"
set "dtStamp=%datestamp%_%timestamp%"
:: Sets release directory from where build shall be copied to remote machine.
SET src=%releaseFrom%
if "%isServerDeployment%" == "true" (
	if "%releaseFrom%" == "" (SET src=.\..\..\target\algo-server-2.35-build) else (SET src=%releaseFrom%)
	:: Delete logback-classic-1.1.2.jar and logback-core-1.1.2.jar . Use /p for prompting user 
	:: before deletion e.g. del /p /s %src%\server\jars\logback-classic-1.1.2.jar
	del /s %src%\server\jars\logback-classic-1.1.2.jar
	del /s %src%\server\jars\logback-core-1.1.2.jar
	echo deleted logback-classic-1.1.2.jar and logback-core-1.1.2.jar from server/jars)   

echo src=%src%  releaseFrom=%releaseFrom% isServerDeployment=%isServerDeployment% dtStamp=%dtStamp%
	
:: Authenticates user on the deployment machine before starting copy and create a drive link.
net use y: \\%ip%\%drive% /user:%user% %password%

:: Writes date time string with description of copy start.
echo Copying started at %date% %time%>>_date_.txt 

:: Copies using robocopy. Always create a new directory.
robocopy %src% y:%dest%\V%dtStamp% /MT:10 /NP /NFL /NDL /MIR /Z

:: Writes information including finished time to _date_.txt
echo Copying finished at %date% %time%>>_date_.txt 
echo Completed Successfully at %date% %time%>>_date_.txt 
echo --------------------------------------------------------------------------- >>_date_.txt 

:: Install starts      --> Uses version.txt for maintaining server version.
del y:%dest%\version.txt
echo V%dtStamp%>>y:%dest%\version.txt
:: Install ends

:: Prints successfull message
echo deployment successfull. build is copied at %dest%\V%dtStamp%

:: Removes directory link.
net use y: /delete

pause
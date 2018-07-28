cd c:\

plink -pw 123456 root@172.17.0.53 cd /ReportGenerator;./RemovePreviousBhavCopyFile.sh


cd c:
PATH=%PATH
cd C:\BhavCopy\
c:\pscp.exe -pw 123456 *.*  root@172.17.0.53:/contracts

pause
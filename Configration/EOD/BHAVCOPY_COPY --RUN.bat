cd c:\
plink -pw 123456 root@172.17.0.55 cd /ReportGenerator;./RemovePreviousBhavCopyFile.sh
plink -pw 123456 root@172.17.0.93 cd /ReportGenerator;./RemovePreviousBhavCopyFile.sh
plink -pw 123456 root@172.17.0.27 cd /ReportGenerator;./RemovePreviousBhavCopyFile.sh
plink -pw 123456 root@172.17.0.153 cd /ReportGenerator;./RemovePreviousBhavCopyFile.sh
plink -pw 123456 root@172.17.0.15 cd /ReportGenerator;./RemovePreviousBhavCopyFile.sh
plink -pw 123456 root@172.17.0.46 cd /ReportGenerator;./RemovePreviousBhavCopyFile.sh
plink -pw 123456 root@172.17.0.42 cd /ReportGenerator;./RemovePreviousBhavCopyFile.sh
plink -pw 123456 root@172.17.0.81 cd /ReportGenerator;./RemovePreviousBhavCopyFile.sh
plink -pw 123456 root@172.17.0.104 cd /ReportGenerator;./RemovePreviousBhavCopyFile.sh
plink -pw 123456 root@172.17.0.143 cd /ReportGenerator;./RemovePreviousBhavCopyFile.sh
plink -pw 123456 root@172.17.0.33 cd /ReportGenerator;./RemovePreviousBhavCopyFile.sh
plink -pw 123456 root@172.17.0.39 cd /ReportGenerator;./RemovePreviousBhavCopyFile.sh
plink -pw 123456 root@172.17.0.53 cd /ReportGenerator;./RemovePreviousBhavCopyFile.sh
plink -pw 123456 root@172.17.0.45 cd /ReportGenerator;./RemovePreviousBhavCopyFile.sh
plink -pw 123456 root@172.17.0.68 cd /ReportGenerator;./RemovePreviousBhavCopyFile.sh
plink -pw 123456 root@172.17.0.23 cd /ReportGenerator;./RemovePreviousBhavCopyFile.sh


cd c:
PATH=%PATH
cd C:\BhavCopy\
c:\pscp.exe -pw 123456 *.*  root@172.17.0.55:/contracts
c:\pscp.exe -pw 123456 *.*  root@172.17.0.93:/contracts
c:\pscp.exe -pw 123456 *.*  root@172.17.0.27:/contracts
c:\pscp.exe -pw 123456 *.*  root@172.17.0.153:/contracts
c:\pscp.exe -pw 123456 *.*  root@172.17.0.15:/contracts
c:\pscp.exe -pw 123456 *.*  root@172.17.0.46:/contracts
c:\pscp.exe -pw 123456 *.*  root@172.17.0.42:/contracts
c:\pscp.exe -pw 123456 *.*  root@172.17.0.81:/contracts
c:\pscp.exe -pw 123456 *.*  root@172.17.0.104:/contracts
c:\pscp.exe -pw 123456 *.*  root@172.17.0.143:/contracts
c:\pscp.exe -pw 123456 *.*  root@172.17.0.33:/contracts
c:\pscp.exe -pw 123456 *.*  root@172.17.0.39:/contracts
c:\pscp.exe -pw 123456 *.*  root@172.17.0.53:/contracts
c:\pscp.exe -pw 123456 *.*  root@172.17.0.45:/contracts
c:\pscp.exe -pw 123456 *.*  root@172.17.0.68:/contracts
c:\pscp.exe -pw 123456 *.*  root@172.17.0.23:/contracts
pause
pause
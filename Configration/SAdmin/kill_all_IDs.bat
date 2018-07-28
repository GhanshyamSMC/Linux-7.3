title 22@kill_all_IDs
cd C:\
pause
timeout 5
plink -pw 123456 root@172.17.0.53 cd /honey/work/admin;./kill_all_IDs.sh
pause
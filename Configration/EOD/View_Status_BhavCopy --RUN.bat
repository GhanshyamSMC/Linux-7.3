cd \
C:
SET cfolder=C:\FIRST\BhavCopyStatus
pscp -r -pw 123456 root@172.17.0.53:/contracts/*.txt %cfolder%\
pscp -r -pw 123456 root@172.17.0.68:/contracts/*.txt %cfolder%\
pscp -r -pw 123456 root@172.17.0.104:/contracts/*.txt %cfolder%\
pscp -r -pw 123456 root@172.17.0.93:/contracts/*.txt %cfolder%\
pscp -r -pw 123456 root@172.17.0.45:/contracts/*.txt %cfolder%\
pscp -r -pw 123456 root@172.17.0.42:/contracts/*.txt %cfolder%\
pscp -r -pw 123456 root@172.17.0.153:/contracts/*.txt %cfolder%\
pscp -r -pw 123456 root@172.17.0.55:/contracts/*.txt %cfolder%\
pscp -r -pw 123456 root@172.17.0.81:/contracts/*.txt %cfolder%\
pscp -r -pw 123456 root@172.17.0.143:/contracts/*.txt %cfolder%\
pscp -r -pw 123456 root@172.17.0.46:/contracts/*.txt %cfolder%\
pscp -r -pw 123456 root@172.17.0.15:/contracts/*.txt %cfolder%\
pscp -r -pw 123456 root@172.17.0.27:/contracts/*.txt %cfolder%\
pscp -r -pw 123456 root@172.17.0.33:/contracts/*.txt %cfolder%\
pscp -r -pw 123456 root@172.17.0.39:/contracts/*.txt %cfolder%\
pscp -r -pw 123456 root@172.17.0.23:/contracts/*.txt %cfolder%\
pause


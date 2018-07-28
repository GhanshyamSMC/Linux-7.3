C:
SET cfolder=C:\Vol_Trades_Backup
pscp -r   -pw 123456 root@172.17.0.55:/Reports/*.txt %cfolder%\
pscp -r   -pw 123456 root@172.17.0.153:/Reports/*.txt %cfolder%\
pscp -r   -pw 123456 root@172.17.0.42:/Reports/*.txt %cfolder%\
pscp -r   -pw 123456 root@172.17.0.81:/Reports/*.txt %cfolder%\
pscp -r   -pw 123456 root@172.17.0.143:/Reports/*.txt %cfolder%\
C:
SET cfolder=C:\Trades_Backup
pscp -r   -pw 123456 root@172.17.0.104:/Reports/*.txt %cfolder%\
pscp -r   -pw 123456 root@172.17.0.93:/Reports/*.txt %cfolder%\
pscp -r   -pw 123456 root@172.17.0.53:/Reports/*.txt %cfolder%\
pscp -r   -pw 123456 root@172.17.0.46:/Reports/*.txt %cfolder%\
pscp -r   -pw 123456 root@172.17.0.15:/Reports/*.txt %cfolder%\
pscp -r   -pw 123456 root@172.17.0.27:/Reports/*.txt %cfolder%\
pscp -r   -pw 123456 root@172.17.0.33:/Reports/*.txt %cfolder%\
pscp -r   -pw 123456 root@172.17.0.39:/Reports/*.txt %cfolder%\
pscp -r   -pw 123456 root@172.17.0.68:/Reports/*.txt %cfolder%\
pscp -r   -pw 123456 root@172.17.0.23:/Reports/*.txt %cfolder%\
pause
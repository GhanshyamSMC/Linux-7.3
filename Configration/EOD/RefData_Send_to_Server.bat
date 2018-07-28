cd\
del /s /q /f \\172.17.0.76\c$\FirstFeed\conf\RefData.txt
del /s /q /f \\172.17.0.38\c$\FirstFeed\conf\RefData.txt
del /s /q /f \\172.17.0.24\c$\FirstFeed\conf\RefData.txt
del /s /q /f \\172.17.0.32\c$\FirstFeed\conf\RefData.txt
del /s /q /f \\172.17.0.144\c$\FirstFeed\conf\RefData.txt
del /s /q /f \\172.17.0.11\c$\FirstFeed\conf\RefData.txt
del /s /q /f \\172.17.0.51\c$\FirstFeed\conf\RefData.txt
del /s /q /f \\172.17.0.47\c$\FirstFeed\conf\RefData.txt
del /s /q /f \\172.17.0.163\c$\FirstFeed\conf\RefData.txt
del /s /q /f \\172.17.0.160\c$\FirstFeed\conf\RefData.txt
del /s /q /f \\172.17.0.191\c$\FirstFeed\conf\RefData.txt
del /s /q /f \\172.17.0.193\c$\FirstFeed\conf\RefData.txt
del /s /q /f \\172.17.0.28\c$\FirstFeed\conf\RefData.txt
del /s /q /f \\172.17.0.170\c$\FirstFeed\conf\RefData.txt
timeout3
cd\
C:
cd RefData
copy /y *.* \\172.17.0.76\c$\FirstFeed\conf\
copy /y *.* \\172.17.0.38\c$\FirstFeed\conf\
copy /y *.* \\172.17.0.24\c$\FirstFeed\conf\
copy /y *.* \\172.17.0.32\c$\FirstFeed\conf\
copy /y *.* \\172.17.0.144\c$\FirstFeed\conf\
copy /y *.* \\172.17.0.11\c$\FirstFeed\conf\
copy /y *.* \\172.17.0.51\c$\FirstFeed\conf\
copy /y *.* \\172.17.0.47\c$\FirstFeed\conf\
copy /y *.* \\172.17.0.163\c$\FirstFeed\conf\
copy /y *.* \\172.17.0.160\c$\FirstFeed\conf\
copy /y *.* \\172.17.0.191\c$\FirstFeed\conf\
copy /y *.* \\172.17.0.193\c$\FirstFeed\conf\
copy /y *.* \\172.17.0.28\c$\FirstFeed\conf\
copy /y *.* \\172.17.0.170\c$\FirstFeed\conf\
pause
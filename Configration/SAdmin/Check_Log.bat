cd\
timeout 5
c:
cd\S1800_Bat_Files
start Check_TBT_Log.bat
timeout 3
start Check_OMS_Log.bat
timeout 3
start Check_Server_Logs.bat
timeout 3
exit
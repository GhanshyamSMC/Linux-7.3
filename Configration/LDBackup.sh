#!/bin/sh
./logs_Bak.sh
./database_Bak.sh
cd /honey/work/logs-backup/
scp -r *.* root@172.17.0.43:/root/Fast_Trades_Logs_Backup/172.17.0.46
cd /honey/work/admin/db-backup/
scp -r *.* root@172.17.0.43:/root/fast_trade_backup_DB/172.17.0.46






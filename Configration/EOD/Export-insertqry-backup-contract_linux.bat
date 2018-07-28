@ECHO OFF

set TIMESTAMP=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%

REM Export all databases into file C:\path\backup\databases.[year][month][day].sql
"C:\Program Files\MySQL\MySQL Server 5.7\bin\mysqldump.exe"  --no-create-db  --databases algo  --ignore-table=algo.security --ignore-table=algo.bhavcopy --ignore-table=algo.executions --ignore-table=algo.watchlist --ignore-table=algo.pnl   --ignore-table=algo.execution_summary --ignore-table=algo.login --ignore-table=algo.risk_properties --ignore-table=algo.text_objects --ignore-table=algo.child_order_audit  --ignore-table=algo.active_child_orders --result-file="C:\honey\work\db-backup\data\insertsqry.%TIMESTAMP%.sql" --user=root --password=root

REM Change working directory to the location of the DB dump file.
C:
CD C:\honey\work\db-backup\data


pause




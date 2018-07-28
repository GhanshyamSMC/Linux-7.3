#!/bin/sh -e
mysqldump -uroot -proot algo >  db-backup/"database"$(date +%Y%m%d).sql



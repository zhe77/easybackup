#!/bin/bash
MYSQL_USER=root
MYSQL_PASS=MySQLrootPassWord
MYSQL_DB_NAME=mywordpressdb
FTP_HOST=ftp.1fichier.com
FTP_PORT=21
FTP_USER=myftpuser
FTP_PASS=myftppassword
FTP_PATH=/
WEB_FILES_PATH=/srv/www/example.com
LOCAL_BACKUP_PATH=~/backup
WEBSITE_NAME=example.com



DB_BACKUP_FILE_NAME=$WEBSITE_NAME.$(date +"%Y%m%d").db
WEBSITE_FILES_BACKUP_FILE_NAME=$WEBSITE_NAME.$(date +"%Y%m%d").webfiles
mysqldump -u $MYSQL_USER -p$MYSQL_PASS $MYSQL_DB_NAME > $DB_BACKUP_FILE_NAME.sql
tar zcf $LOCAL_BACKUP_PATH/$DB_BACKUP_FILE_NAME.tar.gz *.sql
rm -f *.sql
tar zcf $LOCAL_BACKUP_PATH/$WEBSITE_FILES_BACKUP_FILE_NAME.tar.gz $WEB_FILES_PATH
ftp -v -n $FTP_HOST $FTP_PORT<< END
user $FTP_USER $FTP_PASS
type binary
passive
cd $FTP_PASS
put $LOCAL_BACKUP_PATH/$DB_BACKUP_FILE_NAME.tar.gz
put $LOCAL_BACKUP_PATH/$WEBSITE_FILES_BACKUP_FILE_NAME.tar.gz
bye
END

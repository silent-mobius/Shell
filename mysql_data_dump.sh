#!/usr/bin/env bash
set -x
###############################################################################################
#created by Naor Herchkovitch
#Mod by br0k3ngl255
#Purpose :  back up  mysql server.
###############################################################################################

: ' TODO
 create a function to compare the last backup date and current date ( if not the same then back it up)
'

#Vars :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
BACK_UP_FOLDER="/opt/backup/mysql"
BACKUP_LOG="sql.log"
BACKUP=$BACK_UP_FOLDER/$BACKUP_LOG
DATE=`date +"%Y-%m-%d %H:%M"`
# bash script to backup mysql
MYSQL_USER=root
MYSQL_PASSWORD= $1


#Funcs ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
help() { # explain how to use the script
  printf "!!!!!!ERROR!!!!!!\n"
  printf " To run the script user\n"
  printf " mysql_data_dump.sh MYSQL_PASSWORD\n"
  printf " example: mysql_data_dump.sh this_is_my_password"
  printf " NOTE: script is in debugging mode, comment out 'set -x' to make notmal"
}

dump_sql(){ #dumping sql database for backup 
    /usr/bin/mysqldump --user=$MYSQL_USER --password=$MYSQL_PASSWORD --all-databases --lock-all-tables \
    --flush-logs --master-data=2 | bzip2 -c > $MYSQL_BACKUP_DIR/all-$($DATE).sql.bz2 &> $BACKUP  
}
dump_backup() { # backup file system
    rsync -avh --progress --delete /etc/postfix /srv/www \ 
    /home/naorhe/mysql naorhe@192.168.42.156:/Stls_MySql_Backup &> &BACKUP
}
old_sys_remove() { # remove old MySQL database backups
    find $MYSQL_BACKUP_DIR -maxdepth 1 -type f -name *.sql.bz2 -mtime +30 -exec rm -Rf {} \; &> $BACKUP
}

#date +"%Y-%m-%d %X" > $BACKUP_LOG

notify() { # send email
    mailx -s "Micro: sql log" ist@siklu.com < $BACKUP
}


###
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
###

if [ "$EUID" != "0" ];then
   printf " Please escalate the permissions level| get ROOT \n"
   help
elif [ "$EUID" == "0" ];then 
      if [ "$1" == "" ];then
         help
      fi
else
    dump_sql; dump_backup; old_sys_remove ;notify;
fi

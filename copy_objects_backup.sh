#!/bin/bash 

source /home/coder/script/storage_check.sh

DIR="/home/test/"
BACKUP="/home/backup_ack"

copy () {
    mkdir $BACKUP
    if [[ -e $BACKUP ]]
    then
        cp -R $1 $BACKUP
    else
        break
        echo "No possible to create $BACKUP directory"
    fi
}


f_main ()
{
    check_disk
    if [[ $ASP -lt 90 ]]
    then
        copy $DIR
    else
        echo "No possible copy - ASP: ${ASP}%"
    fi
}

f_main 



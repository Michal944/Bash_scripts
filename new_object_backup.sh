#!/bin/bash

PATH_H="/home/coder"


check_file_exist () {
    if [[ -e $PATH_H ]]
    then
        echo "1"
    else
        echo "0"
    fi
}



backup_f () {
    FLAG=$( check_file_exist )
    if [[ FLAG -eq 1 ]]
    then 
        find ${PATH_H}/* -maxdepth 1 -type d -mtime -1 -exec tar -cf /home/coder/backup_last_day.tar {} \;
    else 
        echo "No directory"
    fi
}

backup_f 

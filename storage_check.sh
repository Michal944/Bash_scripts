#!/bin/bash



#storage_check
LOGS="/var/space_disk.log"

check_disk () {
    local DISK="/dev/mmcblk0p1"
    if [[ -e $DISK ]]
    then
	ASP=$( df | grep $DISK | awk '{print $5}' | rev | cut -c 2- | rev )
    else
        ASP=100 
    fi
}

log_gen () {
    echo "At ${DATE} ASP used is $1: ${ASP}%" >> $LOGS 
}

alert () {
    local DATE=$( date "+%H:%M:%S %d-%m-%y" )
    check_disk
    echo "At ${DATE} ASP used is: ${ASP}%" >> $LOGS 
    
    if [[ $ASP -ge 90 ]]
    then 
        log_gen ge
    elif [[ $ASP -lt 90 ]]
    then
        if [[ $ASP -gt 70 ]]
        then
            log_gen 70_GT
        elif [[ $ASP -lt 50 ]]
        then
            log_gen SAFE
        else
            log_gen "we are green"
        fi
    fi
}




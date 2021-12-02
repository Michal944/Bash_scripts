#!/bin/bash

#script to clean log

cleaning_per_size ()
{
    local MAX_SIZE=$1
    local SIZE_LOG=0
   if [[ -d "/var/log" ]] ; then
       PATH_LOG="/var/log"
   else
      echo "no found log directory or no privilages" 
      exit 1
   fi
   ###check the size of folder###

   SIZE_LOG=$( du -s ${PATH_LOG} | awk '{print $1}')
   if [[ $SIZE_LOG -ge $MAX_SIZE ]]
   then
       return 1
   else
       echo "the current size of log file is $(( $SIZE_LOG / 1000))MB"
   fi
}


check_archived_logs ()
{
    echo $PATH_LOG
    LIST_FILE=( $(find $PATH_LOG -name "*.gz") )

    echo ${#LIST_FILE[*]}
    for X in ${LIST_FILE[@]}
    do
        echo $(du ${PATH_LOG}${X:1})
    done
}

cleaning_per_size 100
check_archived_logs 





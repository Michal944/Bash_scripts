#!/bin/bash

TEST=1

 generate_files ()
 {
     EXEC_FILE=0 ; TXT_FILE=0
     PATH_LIST=($( echo $PATH | tr ":" " "))
     #PATH_LIST="/home/coder/script/"
     for P in ${PATH_LIST[@]}
     do
         if [[ $(file $P | awk '{print $2}') = "directory" ]]
         then
             LIST_FILES=($(ls $P))
             for L in ${LIST_FILES[@]}
             do
                 if [[ -x "${P}/$L" ]]
                 then
                     ((EXEC_FILE++))
                 else
                     ((TXT_FILE++))
                 fi
             done
         elif [[ $(file $P | awk '{print $2}') = "symbolic" ]]
         then
             local SYMBOLIC=$(file $P | awk '{print $5}')
             if [[ $( echo ${PATH_LIST[@]} | grep -wc ${SYMBOLIC}) ]] 
             then
                 continue
             else
                LIST_FILES=($(ls $P))
                for L in ${LIST_FILES[@]}
                do
                    if [[ -x "${P}/$L" ]]
                    then
                     ((EXEC_FILE++))
                    else
                     ((TXT_FILE++))
                    fi
                done
             fi
         fi
     done
     echo "EXEC FILE: $EXEC_FILE"
     echo "TXT  FILE: $TXT_FILE"

}

generate_files


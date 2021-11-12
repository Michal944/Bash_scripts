#!/bin/bash


PATH1="/etc/passwd"
users_bash () {

    SHELL_1="bash"

    if [[ -e $PATH1 ]] 
    then 
    MESSAGE=$( cat $PATH1 | grep $SHELL_1 | wc -l )
    fi 

    echo "The user possible to log in to Bash shell" 
    echo $MESSAGE
}

who_is_login () {
    local MESSAGE=$( who | awk '{print $1}' | sort | uniq | wc -l )
    echo "Who is log in: ${MESSAGE}"
}

free_memory () {
    local MEMORY=$( free -m | tail -n 2 | head -n 1 | awk '{print $4}' )
    echo "Free memory ${MEMORY}"
}


folders_files () {

    local DIR=${1}
    if [[ -e $DIR ]] 
    then
        FOLDER=$( find $DIR -type d | wc -l )
        #FOLDER=${FOLDER}-1 
        ((FOLDER--))
        echo "HOW MANY FOLDER IS IN ${DIR}: ${FOLDER}"
        FILES=$( find $DIR -maxdepth 1 -type b | wc -l )
        echo "HOW MANY FILE/BLOCKS is in${DIR}: ${FILES}"
    elif [[ ! -e $DIR ]]
    then
        echo "Dir not exist"

    fi
}




users_bash
who_is_login
free_memory
folders_files /devsad

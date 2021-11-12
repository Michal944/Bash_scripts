#!/bin/bash

go_home () {
    if [[ -e $HOME ]]
    then 
        cd $HOME
    elif [[ -e "/home/" ]]
    then
        cd "/home/"
    fi
}


crt_objects () {
    local DIR="directory_test"
    go_home
    mkdir $DIR
    if [[ -e $DIR ]]
    then
        cd $DIR
        X=0
        while [[ $X -lt 100 ]]
        do
            touch $X
            if [[ $(($X%2)) -eq 0 ]]
            then
                echo "Hello world $X" >> $X 
            fi
            ((X++))
        done
    fi
}

crt_objects



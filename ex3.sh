#!/bin/bash 


print_name () {
    read -p "Podaj swoje imie: " NAME
    read -p "Podaj swoje Nazwisko: " VORNAME

    if [[ -n $NAME && -n $VORNAME ]]
    then
        echo "${NAME} and ${VORNAME}" >> /home/coder/wiz.txt
    fi
}



print_name 

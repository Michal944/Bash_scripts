#!/bin/bash


#Only numeric data accepted and no more than 4 digitis
input_data () {
    read -p "Podaj rok w formacie XXXX:   " YEAR
    if [[ ! -z $YEAR ]] 
    then
        if [[ $( echo $YEAR | grep -c [a-zA-Z./+,] ) -eq 0 && ${#YEAR} -eq 4 ]] 
        then 
            echo "Data to ${YEAR}" 
        elif [[  $( echo $YEAR | grep -c [a-zA-Z./+,] ) -gt 0 ]]
        then
            echo "Niepoprawny format daty"
        elif [[  ${#YEAR} -ne 4 ]] 
        then
            echo "Niepoprawna dlugosc daty"
        fi
    fi
}

input_data




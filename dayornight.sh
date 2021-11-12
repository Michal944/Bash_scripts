#!/bin/bash


date_gen () {
    HOUR=$( date +%H )
}


dayornight () {
    date_gen
    if [[ $HOUR -ge 7 && $HOUR -le 18 ]]
    then 
        echo "at now it's day and sun"
    elif [[ $HOUR -gt 18 && $HOUR -lt 21 ]]
    then
        echo "To night is comming"
    elif [[ $HOUR -lt 7 || $HOUR -ge 21 ]]
    then
        echo "it's night" 
    fi
}


dayornight 



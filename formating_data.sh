#!/bin/bash





months_select () 
{
    case $( echo $2 | tr '[:upper:]' '[:lower:]' ) in
        jan* | 1 ) days=31 ;;
        feb* | 2 ) days=28 ;;
        mar* | 3 ) days=31 ;;
        apr* | 4 ) days=30 ;;
        may* | 5 ) days=31 ;;
        jun* | 6 ) days=30 ;;
        jul* | 7 ) days=31 ;;
        aug* | 8 ) days=31 ;;
        sep* | 9 ) days=30 ;;
        oct* | 10 ) days=31 ;;
        nov* | 11 ) days=30 ;;
        dec* | 12 ) days=31 ;;
        *) echo "wrong month" 
    esac       
        if [[ $1 -le $days ]]
        then
            echo "poprawna data"
        else
            echo "nieporawna data"
        fi
}









#!/bin/bash


read -p "Podaj nr dnia tygodnia [1-7]" DAY

re_day () {
    case $DAY in
        1)
            echo "Monady | Poniedzialek"
            ;;
        2)
            echo "Thusday | Wtorek"
            ;;
        3)
            echo "Wednesday | Sroda"
            ;;
        4)
            echo "Thursday | Czwartek"
            ;;
        5)
           echo "Friday | Piatek"
           ;;
       6 | 7)
           echo "Weekend"
           ;;
       *)
           echo "WRONG VALUE"
           ;;
    esac
}

re_day 



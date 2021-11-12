#!/bin/bash 


HOST_NET=($(nmap -sP 192.168.1.0-255 | sort | grep "Nmap scan" | awk '{print $5}'))

echo ${HOST_NET[1]} 
echo "========================================"
echo ${#HOST_NET[*]} #HOSTS liczba
echo ${HOST_NET[*]} #all hosts displ




#Open ports

open_port () {
    local REGEX_TCP="tcp$"
    local REGEX_UDP="udp$"
    O_PORTS=($(nmap -p $1 $2 | grep "^[0-9]" | awk '{print $1}'))
    for PORT in ${O_PORTS[*]}
    do
        if [[ $PORT =~ $REGEX_TCP ]]
        then
            echo "TCP-OPEN: ${PORT}"
        elif [[ $PORT =~ $REGEX_UDP ]]
        then
            echo  "UDP-OPEN: $PORT"
        else
            echo "NO find the protocol - $PORT"
        fi
    done

}


open_port "0-1000" localhost

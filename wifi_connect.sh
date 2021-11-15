#!/bin/bash


check_iw () {
    NAME_WLAN=$(iw dev | grep -iw wlan[0-9] | awk '{print $2}'
}

check_status () {
    if [[ -n $NAME_WLAN ]]
    then
        WLAN=$(ip link show wlan0 | awk '{print $9}' | head -n 1)
    else
        exit 1
    fi
    
    if [[ -n $WLAN ]]
    then
        case $WLAN in
            "UP")
                echo "$NAME_WLAN is UP"
                ;;
            "DOWN")
                ip link set $NAME_WLAN up
                ;;
            *)
                exit 1
                ;;
        esac
    else
        exit 1
    fi
}

check_conn ()
{
    local STATUS=$(iw $NAME_WLAN link)
    if [[ $STATUS == "Not connected." ]]
    then
        FLAG_OI=0
    else
        FLAG_OI=1
    fi
}

scan_network_wifi () {

    if [[ $USER == "root" ]]
    then
        SSID_LIST=($(iw wlan0 scan | grep SSID ))
        if [[ -n $SSID_LIST ]]
        then
            local NR=1
            for X in ${SSID_LIST[@]} 
            do
                echo $NR: $X
                ((NR++))
            done
        else
            echo "No Network to connect"
            exit 0
        fi 
        read -p "Connect to one of the network in the list: " WIFI
        WIFI=${SSID_LIST[(($WIFI-1))]}
    else
        echo "You have to run the script as a root or sudo"
        exit 1
    fi

}

generate_conf_file () {
    if [[ -n $WIFI ]]
    then
        read -p "Password for $WIFI: " PASSWORD
        if [[ -n $PASSWORD ]]
        then
            wpa_passphrase $WIFI $PASSWORD  >> /etc/wpa_supplicant.conf
        else
            echo "no password"
            exit 1
        fi
     fi
     cat /etc/wpa_supplicant.conf 
 }

connect_to_network () {

    wpa_supplicant -B -D wext -i $NAME_WLAN  -c /etc/wpa_supplicant.conf
    dhclient $NAME_WLAN
    ip route show
    ping 8.8.8.8 -c 4 

    SCRIPT=(
            "root@kali:~# iw dev"
            "root@kali:~# ip link set wlan0 up"
            "root@kali:~# iw wlan0 scan"
            "root@kali:~# wpa_passphrase blackMOREOps >> /etc/wpa_supplicant.conf"
            "root@kali:~# wpa_supplicant -i wlan0 -c /etc/wpa_supplicant.conf"
            "root@kali:~# iw wlan0 link"
            "root@kali:~# dhclient wlan0"
            "root@kali:~# ping 8.8.8.8"
            "root@kali:~# ip route add default via 10.0.0.138 dev wlan0"
        )
    
}

check_iw
check_status
check_conn
scan_network_wifi
generate_conf_file
connect_to_network

#END

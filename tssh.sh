#!/bin/bash


#MAIN_GIF

echo "░██████╗░██████╗██╗░░██╗  ████████╗██╗░░░██╗███╗░░██╗███╗░░██╗███████╗██╗░░░░░"
echo "██╔════╝██╔════╝██║░░██║  ╚══██╔══╝██║░░░██║████╗░██║████╗░██║██╔════╝██║░░░░░"
echo "╚█████╗░╚█████╗░███████║  ░░░██║░░░██║░░░██║██╔██╗██║██╔██╗██║█████╗░░██║░░░░░"
echo "░╚═══██╗░╚═══██╗██╔══██║  ░░░██║░░░██║░░░██║██║╚████║██║╚████║██╔══╝░░██║░░░░░"
echo "██████╔╝██████╔╝██║░░██║  ░░░██║░░░╚██████╔╝██║░╚███║██║░╚███║███████╗███████╗"
echo 'INFO: https://erev0s.com/blog/ssh-local-remote-and-dynamic-port-forwarding-explain-it-i-am-five/'
PERM=0

check_root () {
    if [[ $USER = "root" ]]
    then
        PERM=1
    else
        PERM=0
    fi
}



f_printip () {
    check_root
    case $PERM in
        1)
            local I_NET=($(ip -4 addr | grep "^[[:digit:]]:" | awk '{print $2}'))
            local I_IP=($(ip a | grep -w inet | awk '{print $1"-"$2}'))
    
            for (( X=0 ; X < ${#I_NET[@]} ; ++X ))
            do
                INTERFACES+=("${I_NET[$X]}-${I_IP[$X]}")       
               echo ${INTERFACES[$X]} 
            done
            ;;
          0)
            echo "You are not a root! Please use sudo command before you run this command"
            exit 0
            ;;
    esac
}

f_ssh_local () {
   #LOCAL SSH TUNNEL
   echo 'ssh -Nf -L LOCAL_PORT:DESTINATION_ADDRESS:DESTINATION_PORT USER_HUB@ADDRESS:HUB'
   echo 'LOCAL_H ------> HUB ======>DEST_SERVER/HOST'
   ssh -Nf -L  ${LOCAL_PORT}:${DESTINATION_ADDRESS}:${DESTINATION_PORT} ${USER_HUB}@${IP_HUB}
    
}

f_ssh_remote () {
    #REMOTE SSH TUNNEL
    echo ' ssh -Nf -R ${LOCAL_PORT}:"localhost":${REMOTE_PORT} ${HUB_ADDRESS}'
    echo ' LOCAL_H <<<<-------- HUB <----INTERNET/REMOTE_HOST'
    echo 'AllowTcpForwarding remote     AllowStreamLocalForwarding no MANDATORY!!!!'
    ssh -Nf -R ${LOCAL_PORT}:"localhost":${REMOTE_PORT} ${HUB_ADDRESS}
}

f_ssh_dynamic () {
    #DYNAMIC SSH TUNNEL - PROXY
    echo 'ssh -Nf -D ${LOCAL_PORT}:${REMOTE_IP}'
    echo 'L_HOST ->>>>> REMOTE_IP -> RANDOM_WEBSITE/random service....'  
    ssh -Nf -D ${LOCAL_PORT}:${REMOTE_IP} 
}


#___SETUP!!!___
setup () {
    case $TYPE in
        L|l)
            LOCAL_PORT=5000
            DESTINATION_ADDRESS="10.1.1.50"
            DESTINATION_PORT=22
            USER_HUB="coder"
            IP_HUB="192.168.1.45"
            f_ssh_local
            ;;
        R|r)
            LOCAL_PORT=22
            REMOTE_PORT=4000
            HUB_ADDRESS="ala@example.com"
            f_ssh_remote
            ;;
        D|d)
            LOCAL_PORT=4000
            REMOTE_IP="1.2.3.4"
            f_ssh_dynamic
    esac
}


read -p "Type tunnel R/L/D: " TYPE
setup






    

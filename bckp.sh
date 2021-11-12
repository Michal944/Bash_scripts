#!/bin/bash

PATH1="/home/coder"
PATH2="/home/tmp"
PATH3="$PATH2/backup.tar"
PATH4="$PATH1/python"



cd $PATH2 2>/dev/null 
if [[ $( pwd ) != $PATH2 ]] 
then 
	mkdir $PATH2
	cd $PATH2
fi

MESSAGE=$( tar -cvf $PATH3 $PATH4 2>/dev/null )


echo $MESSAGE	

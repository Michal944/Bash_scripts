#!/bin/bash


download_kernel ()
{
	NAME_FILE="new_kernel"
	echo "${#FILES_LIST[@]}"
	LOG_FILE="kernel_update.log"
	cd $HOME && mkdir $NAME_FILE | tee -a $LOG_FILE
	if [[ -d "$HOME/$NAME_FILE" ]]
	then
		cd "$HOME/$NAME_FILE"
		X=0
		echo "Downloading the kernel files from the list_files.txt file"
		while [[ $X -lt ${#FILES_LIST[@]} ]]
		do
			
			echo "Downloading the ${FILES_LIST[$X]}: " | tee -a $LOG_FILE
			wget ${FILES_LIST[$X]} | tee -a $LOG_FILE
			if [[ -e $(basename ${FILES_LIST[X]}) ]]
			then
				echo "DOWNLOADED $(basename ${FILES_LIST[X]}) " | tee -a $LOG_FILE
			else
				echo "---NOT--- DOWNLOAED $X" | tee -a $LOG_FILE
				echo "Unexpected result! EXIT program" | tee -a $LOG_FILE
				exit 1
			fi
			((X+=1))
		done
	fi

}

installing_kernel ()
{
	echo "PROCESS IS GOING TO START"
	cd "$HOME/$NAME_FILE" || exit 1
     	#You must be a root
	pwd
	if [[ $USER = "root" ]]
	then
		dpkg -i *.deb | tee -a $LOG_FILE
	else
		echo "You are not a root" | tee -a $LOG_FILE
		exit 1
	fi
}


mainf ()
{
	read -p "Create list_files.txt and wait" 
	if [[ -e "list_files.txt" ]]
	then
		FILES_LIST=( $(cat list_files.txt))
	else
		exit 1 
	fi
	download_kernel
	read -p "READY TO INSTALL NEW KERNEL VERSION? Y/N: " FLAG
	FLAG=$( echo $FLAG | tr 'A-Z' 'a-z' )
	echo $FLAG
	case $FLAG in
		y)
		 	installing_kernel
			;;
		n)
			echo "GOODBYE"
			exit 1
			;;
		*)
			echo "WRONG FLAG" 
			;;
	esac
}


mainf












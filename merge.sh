#!/bin/bash

#Kristin Pflug
#Assignment 1: Merge 'Em
#Bash script that merges two files

file1=''
file2=''
newFile=''
exitStat=0

#If the user does not give enough arguments, print usage statement and exit
if [ "$#" -gt 0 -a "$#" -lt 3 ]; then
    echo "usage: merge.sh [FILE FILE FILE]"
	#print error to log file
	echo "merge failed" >> log.txt
    exit 1
#If the user enters all the arguments in the command line, proceed
elif [ "$#" -eq 3 ]; then
    file1=$1
    file2=$2
    newFile=$3
else
    #Prints prompt to enter arguments, then reads them from the command line
    echo -n "Enter files to merge > "
    read f1 f2 newF
    file1=$f1; file2=$f2; newFile=$newF

    if [ -z $file1 ]; then
        echo "First file name not supplied"
		exitStat=1
    fi
    if [ -z $file2 ]; then
        echo "Second file name not supplied"
        echo "Cannot perform merge, please check files"
        exit 1
    fi
fi

#Check if the files to be merged both exist
if [ ! -e "$file1" ]; then
    echo "$file1 does not exist"
    #set the exit status to 1
	exitStat=1
else
	#Check read/write/execute permissions for file 1
	if [ ! -r "$file1" ]; then
		echo "$file1 does not have read permissions"
		#set the exit status to 1
		exitStat=1
	fi
	if [ ! -w "$file1" ]; then
		echo "$file1 does not have write permissions"
		#set the exit status to 1
		exitStat=1
	fi
	if [ ! -x "$file1" ]; then
		echo "$file1 does not have executable permissions"
		#set the exit status to 1
		exitStat=1
	fi
fi
	#Check read/write/execute permissions for file 2
	if [ ! -e "$file2" ]; then
		echo "$file2 does not exist"
		#set the exit status to 1
		exitStat=1
	else
	if [ ! -r "$file2" ]; then
		echo "$file2 does not have read permissions"
		#set the exit status to 1
		exitStat=1
	fi
	if [ ! -w "$file2" ]; then
		echo "$file2 does not have write permissions"
		#set the exit status to 1
		exitStat=1
	fi 
	if [ ! -x "$file2" ]; then
		echo "$file2 does not have executable permissions"
		#set the exit status to 1
		exitStat=1
	fi
fi

#Checks if the merge file already exists
if [ -e "$newFile" ]; then
    echo "$newFile already exists"
	#set the exit status to 1
	exitStat=1
fi

#if exitStat is 0 then merge, else exit with error
if [ "$exitStat" -eq 0 ]; then
	#Merge files using cat
	echo  "------------$file1---------------" >> $newFile
	cat $file1 >> $newFile
	echo -e "\n------------$file2---------------" >> $newFile
	cat $file2 >> $newFile
	#write result to log
	echo "merge success" >> log.txt
	exit 0
else
	echo "Cannot perform merge, please check files"
	#write result to log
	echo "merge fail" >> log.txt
	exit 1
fi

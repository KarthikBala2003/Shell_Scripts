#!/bin/bash

FOLDER="C:\Users\karth\OneDrive\Pictures"

function list-all-pictures() {
	if [ d$FOLDER ]
	then
		goto FolderExists
	else
		goto FolderNotExists	
	fi
	
:FolderNotExists
	echo "Given folder $FOLDER not exists" 
	exit 1

:FolderExists
	for l in $(ls $FOLDER)
		do
		 echo $l
		done

	exit 0
}

list-all-pictures

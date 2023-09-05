#!/bin/bash

function getOSType() {
# Display running OS name
	case "$OSTYPE" in
  		solaris*) echo "SOLARIS" ;;
  		darwin*)  echo "OSX" ;;
  		linux*)   echo "LINUX" ;;
  		bsd*)     echo "BSD" ;;
  		msys*)    echo "WINDOWS" ;;
  		cygwin*)  echo "Git Bash WINDOWS" ;;
  		*)        echo "unknown: $OSTYPE" ;;
		esac
}

OS_Type=$(echo $(getOSType))

if [ $OS_Type = "LINUX" ]
then
	echo This is Linux System
	pwd
fi

if [ $OS_Type = "WINDOWS" ]
then
	echo This is Windows System
	pwd
fi

#!/bin/bash

read -e -sp "Message1: " msg1
read -e -sp "Message2: " msg2
read -e -sp "Message3: " msg3
# echo -e "\n${msg1@Q}\n"
# echo "${msg1}"


# cho 'Welcome to TutorialKart'
 
# read -p 'Username: ' username
# read -sp 'Password: ' password
 
# echo
# echo "Thank you $username for showing interest in learning with www.tutorialkart.com"
 
# ## this echo is for demo purpose only, never echo password
# echo "Your password is $password"


echo sedeasy_improved $msg1 $msg2 $msg3
function sedeasy_improved {
    arg1=$1
    arg2=$2
    arg3=$3
    
    sed -i "s/$(
        echo "$1" | sed -e 's/\([[\/.*]\|\]\)/\\&/g' 
            | sed -e 's:\t:\\t:g'
    )/$(
        echo "$2" | sed -e 's/[\/&]/\\&/g' 
            | sed -e 's:\t:\\t:g'
    )/g" "$3"
}
#!/bin/bash

printf "Please enter encription password: "
read -s encryptPassword

echo

secret=" "

while [ ! -z "$secret" ]
do
	printf "Enter secret (enter to end): "
	read -s secret

	echo

	[ ! -z "$secret" ] && echo -n "$secret"|openssl enc -e -aes-256-cbc -pbkdf2 -a -k $encryptPassword
done
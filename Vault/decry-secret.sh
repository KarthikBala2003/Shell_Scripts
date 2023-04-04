#!/bin/bash
# DaddyCool

# Blueberry
# U2FsdGVkX1+dAvK4dMW/Z9BUBmdiCnAQ+/DT0VUI7vM=

# Strawberry
# U2FsdGVkX1+8qyFKnTluaPFT2ntRtKmzkdOrKdqKFo0=

printf "Please enter decryption password: "
read -s decryptPassword

echo

vault server -dev -dev-root-token-id="root" &

sleep 1

 VAULT_ADDR=http://localhost:8200
 VAULT_TOKEN="root"
 
 function decrypt {
	echo "$1" | openssl base64 -d|openssl enc -d -aes-256-cbc -pbkdf2 -a -k $decryptPassword
 }

vault kv put secret/test/api/secret client_secret=$(decrypt "U2FsdGVkX1+dAvK4dMW/Z9BUBmdiCnAQ+/DT0VUI7vM=")
vault kv put secret/test/api/vender access_token=$(decrypt "U2FsdGVkX1+8qyFKnTluaPFT2ntRtKmzkdOrKdqKFo0=")

wait

#!/bin/bash

SCRIPT_PASSKEY="./passkeyreturn.sh"
DECRYPT_PASSKEY="./passkey.sh"
SCRIPT_ENCR_DECR="encryptdecrypt.sh"
ENCRPT_FUNC=encryptData
DECRYPT_FUNC=decryptData

getfileinput() {
  read -p 'Enter source filename: ' SRC_INPUT_FILENAME
}

getfileoutput() {
  read -p 'Enter encryption filename: ' SRC_OUTPUT_FILENAME
}

getencryptedfile() {
  read -p 'Enter encrypted filename: ' ENCRYPTED_FILENAME
}

getdecryptedoutfile() {
  read -p 'Enter decrypting output filename: ' DECRYPT_OUT_FILENAME
}


listOptions () {
  echo -ne "
What Operation you want to do?
1) Start Encryption
2) Start Decryption
3) Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
      echo 'Encrypting';;
    2)
      echo 'Decrypting';;
    3)
      echo 'Exiting'
      exit 0;;
    *)
      echo 'Wrong option'
      exit 0;;
    esac
}

listOptions
# echo "$ans"

source "$SCRIPT_ENCR_DECR"

if [[ "$ans" -eq 1 ]]; then 
    PASSKEY=$("$SCRIPT_PASSKEY")
    getfileinput
    getfileoutput
    $ENCRPT_FUNC "$PASSKEY" "$SRC_INPUT_FILENAME" "$SRC_OUTPUT_FILENAME"
elif [[ "$ans" -eq 2 ]]; then
   PASSKEY=$("$DECRYPT_PASSKEY")
   getencryptedfile
   getdecryptedoutfile
   $DECRYPT_FUNC "$PASSKEY" "$ENCRYPTED_FILENAME" "$DECRYPT_OUT_FILENAME"
  else
    exit 0
fi;
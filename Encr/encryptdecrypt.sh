#!/bin/bash

encryptData () {
  passkey="${1}"
  src_file="${2}"
  encrypt_file="${3}"
  openssl enc -in "${src_file}" -out "${encrypt_file}" -e -aes256 -pass "pass:${passkey}" -pbkdf2
}

decryptData () {
  passkey="${1}"
  echo ${passkey}
  enc_file="${2}"
  decrypt_file="${3}"
  openssl enc -in "${enc_file}" -out "${decrypt_file}" -d -aes256 -pass "pass:${passkey}" -pbkdf2
}

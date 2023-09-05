#!/bin/bash

fetchPasskey () {
  read -p 'Enter your new pass key: ' PASSKEY
  return $PASSKEY
}

fetchPasskey
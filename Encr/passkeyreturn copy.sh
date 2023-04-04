#!/bin/bash

fetchPasskey () {
  read -p 'Enter your pass key: ' PASSKEY
  return $PASSKEY
}
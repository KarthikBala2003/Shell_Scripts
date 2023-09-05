#!/bin/bash

vault_creds=`cat ./vault_response.json`
echo "$vault_creds"

USR_KEY="usr1_key"
USR_VAL="usr1_val"

# ==================================== Working Code ====================================
# Get Secret Key and value - Below Code working as expected from input
# sec_key="$(echo $vault_creds| grep -Po '"usr1_key": *\K"([^"]*")' | sed 's/"//g')" 
# sec_val="$(echo $vault_creds | grep -Po '"usr1_val": *\K"([^"]*")' | sed 's/"//g')"
# ======================================================================================


# ==================================== Not Working Code ====================================
# Get Secret Key and value - Below Code working as expected from input
sec_key="$(echo $vault_creds| grep -Po '$USR_KEY: *\K"([^"]*")' | sed 's/"//g')" 
sec_val="$(echo $vault_creds | grep -Po '$USR_KEY: *\K"([^"]*")' | sed 's/"//g')"
# ======================================================================================

echo Secret Key: $sec_key 
echo Secret Value: $sec_val

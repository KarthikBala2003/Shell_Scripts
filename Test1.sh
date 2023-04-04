#!/bin/bash

# ./Test1.sh -n team1600-autocri -m ChangeCandidateCICD -k sec_usr_id -v sec_usr_key

CRI_NAMESPACE=team1600-autocri
APP_PATH_NAME=DataGatherCICD
SEC_KEY_ID=sec_usr_id
SEC_VAL_ID=sec_usr_key
ENV_VAULT=k8s-test-edco

# Initializing Input Parameters
while getopts n:m:k:v: option
	do
		case "${option}"
		in
		n) NAME_SPACE=${OPTARG};;
		m) APP_MOUNT_PATH=${OPTARG};;
		k) CRED_KEY=${OPTARG};;
		v) CRED_VALUE=${OPTARG};;
		esac
	done

CRI_NAMESPACE_NAME="${NAME_SPACE:-$CRI_NAMESPACE}"
APP_PATH="${APP_MOUNT_PATH:-$APP_PATH_NAME}"
SEC_KEY="${CRED_KEY:-$SEC_KEY_ID}"
SEC_VAL="${CRED_VALUE:-$SEC_VAL_ID}"

# Get Input Parameters
function Initialize_Paramenters(){
	while getopts n:m:k:v: option
		do
			case "${option}"
			in
			n) NAME_SPACE=${OPTARG};;
			m) APP_MOUNT_PATH=${OPTARG};;
			k) CRED_KEY=${OPTARG};;
			v) CRED_VALUE=${OPTARG};;
			esac
		done

CRI_NAMESPACE_NAME="${NAME_SPACE:-$CRI_NAMESPACE}"
APP_PATH="${APP_MOUNT_PATH: - $APP_PATH_NAME}"
SEC_KEY="${CRED_KEY:-$SEC_KEY_ID}"
SEC_VAL="${CRED_VALUE:-$SEC_VAL_ID}"

# Declare Variables
SERVICE_ACCOUNT=service-account

# Print all assigned variables
# echo $CRI_NAMESPACE_NAME
# echo $APP_PATH
# echo $SEC_KEY
# echo $SEC_VAL
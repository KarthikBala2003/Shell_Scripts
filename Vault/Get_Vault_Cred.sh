#!/usr/bin/env sh

# /bin/bash
# Author:		Karthik Bala
# Date:			08/27/2020
# Description:	This script generate token and login vault
# 				It retrieves client token and secret key /value details for the given vault mount
#
# Input Param 1:	Name_space
# Input Param 2:	Application_Name_Path in Vault
# Input Param 3:	Security Key Name to retrieve from Vault	
# Input Param 4:	Security Value Name to retrieve from Vault
# Date Modified:	07/27/2021

# Usage Example:	./Get_Vault_Cred.sh -n team1600-autocri -m ChangeCandidateCICD-k sec_usr_id -V sec_usr_key

# Application_name_Path in Vault
# DataGather Service:		DataGatherCICD
# ChangeCandidate Service: 	ChangeCandidateCICD
# OnLine Service:		 	Online ServiceCICD
# Splunk API:				autocri-instrumenting
# I
#

# Include trybatch.sh as a library
source ./exceptionhandler.sh

# Define custom exception types
export ERR_BAD=100
export ERR_WORSE=101
export ERR_CRITICAL=102

CRI_NAMESPACE=team1600-autocri
APP_PATH NAME=DataGatherCICD
SEC_KEY_ID=sec_usr_id
SEC_VAL_ID=sec_usr_key
ENV_VAULT=k8s-test-edco

#kubectl get serviceaccount team1600-autocri-service-account -0 yaml | awk /namespace :/ {print $2}'
#datagather-cicd-test /DataGatherCICD
# Vault OIDC Login
# export VAULT_ADDR=https://vault.opr.statefarm.org:8200
# vault login -method=oidc -path=sf_login
# export VAULT_ADDR=https://vault.opr.statefarm.org:8200

# vault login -method=oidc -path=sf_login

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
			APP_MOUNT_PATH=${OPTARG};;
			k) CRED_KEY=${OPTARG};;
			v) CRED_VALUE=${OPTARG};;
			esac
		done

CRI_NAMESPACE_NAME="${NAME_SPACE:-$CRI_NAMESPACE}"
APP_PATH="${APP_MOUNT_PATH: - $APP_PATH_NAME}"
SEC_KEY="${CRED_KEY:-$SEC_KEY_ID}"
SEC_VAL="${CRED_VALUE:-$SEC_VAL_ID}"

# Declare VAULT Variables
VAULT_MOUNT_NAME=datagather-cicd-test
VAULT_MOUNT_LOC=team1600-autocri-test
VAULT_LOGIN_URL=https://vault.opr.statefarm.org:8200/v1/auth/$ENV_VAULT/Login
VAULT_MOUNT_URL=https://vault.opr.statefarm.org:8200/11/SVAULT MOUNT_NAME/SAPP_PATH

# Declare Variables
SERVICE_ACCOUNT=service-account

#============================================ EXCEPTION HANDLING =============================================

function Check_Excetion(){
	status=$?
	if ( $status -eq 1 ]; then
	echo "General error"
	elif [ $status -eq 2 ]; then
	echo "Misuse of shell builtins"
	elif [ $status -eq 126 ]; then
	echo "Command invoked cannot execute"
	elif [ $status -eq 128 ]; then
	echo "Invalid argument"
	fi
}
#================================================  FUNCTIONS ===================================================

# Get K8s namespace
function Get_Namespace(){
	name_space=$(kubectl get pods -o jsonpath='{.items[0].metadata.namespace}')
	if ( -z "$name_space" ]
	then
	I
	| CRI_NAMESPACE_NAME=${1:-$CRI_NAMESPACE}
	else
	| CRI_NAMESPACE_NAME=$name_space
	fi
	# echo $CRI NAMESPACE_NAME
}

# Get Vault Secrets Token
function Get_Secrets_Token() {
	service_account_name=$CRI_NAMESPACE_NAME-$SERVICE_ACCOUNT
	secrets_name=$(kubectl get serviceaccount $service_account_name -O=jsonpath='{.secrets[0].name}')
}

# Get JWT token
function Get_Jwt_Token() {
	jwt_token=$(kubectl describe secret $secrets_name -n $CRI_NAMESPACE_NAME | awk '/token:/ {print $2}')
}

# Login to Vault and Get Client token
function Get_Vault_Login_Token() {
	login_vault_token=$(curl -s --insecure --request POST --data "{\"fwt\":\"$Jwt_token\", \"role\":\"$VAULT_MOUNT_LOC\"}" $VAULT_LOG)
}

# Get Vault Credentials
function Get_Vault_Credentials(){
	vault_creds=$(curl -s --insecure --header "X-Vault-Token: $login_vault_token" -X GET $VAULT_MOUNT_URL --Write-out '%{json}' )
}

# Get Secret Key and Value
Get_Vault_Secret_Key(){
	sec_key="$(echo $vault_creds | grep - Po '"'$1'": *\K"([^"]*")'| sed 's/"//g')"
	sec_val="$(echo $vault_creds | grep - Po '""'$2'": *\K"([^"]*")'| sed 's/"//g')"
}

#Get Secret Key and Value
Get_Vault_Secret_AllKeys(){
	sec_key="$(echo $vault_creds | grep -Po '"'$1'": *\K"([^"]*")'| sed 's/"//g')"
	sec_val="$(echo $vault_creds | grep -Po '"'$2'": *\K"([^"j*")'| sed 's/"//g')"
}

# Get namespace
Get_Namespace

Get_Secrets_Token
#
# echo $secrets_name
# echo

Get_Jwt_Token
# echo $jwt_token
# echo

Get_Vault_Login_Token
echo $login_vault_token
# echo

Get_Vault_Credentials
# echo $vault creds
# echo

Get_Vault_Secret_Key "${SEC_KEY}" "${SEC_VAL}"
echo Secret Key: $sec_key
echo Secret Value: $sec_val
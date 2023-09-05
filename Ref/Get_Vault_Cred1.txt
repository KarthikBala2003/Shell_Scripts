#Get user input for service account
#service account_name=$1

# VAULT_LOGIN_URL=https://vault.opr.statefarm.org:8200/v1/auth/k8s-test-edco/login
# VAULT_MOUNT_URL=https://vault.opr.statefarm.org:8200/v1/datagather-cicd-test/DataGatherCICD

VAULT_LOGIN_URL=http://127.0.0.1:8200/v1/auth/login
VAULT_MOUNT_URL=http://127.0.0.1:8200/v1/secret/data/foo
LOGIN_VAULT_TOKEN=s.PlTRNQKFla3spYIiZPlGMooa

export VAULT_ADDR='http://127.0.0.1:8200'
#Set Key Values
KEY_VAL_NEW='"usr1_key"'
# VAULT_MOUNT_LOC=team1600-autocri-test

# Get namespace
# name_space=$(kubectl get pods -o jsonpath='{.items[0].metadata.namespace}')

#Get secrets
# service_account_name=$name_space-service-account
# secrets_name=$(kubectl get serviceaccount $service_account_name -o=jsonpath='{.secrets[0].name}') 

#Get JWT token
# jwt_token=$(kubectl describe secret $secrets_name -n $name_space | awk '/token:/ {print $2}') 

#Login to Vault and Get client token
# login_vault_token=$(curl -s -insecure --request POST --data "{\"jwt\":\"$jwt_ token\", \"role\ ":\"$VAULT_MOUNT_LOC\"}" $VAULT_LOGIN_URL | grep -Po "client_token": *\K"([^"]*") I sed 's/"//E')

## Get Vault Credentials
vault_creds=$(curl -s --insecure --header "X-Vault-Token: $LOGIN_VAULT_TOKEN" -X GET $VAULT_MOUNT_URL -write-out '{json}') 
echo "$vault_creds"	

# #Get Secret Key and value
sec_key="$(echo $vault_creds| grep -Po '"usr1_key": *\K"([^"]*")' | sed 's/"//g')" 
# sec_key="$(echo $vault_creds| grep -Po '$(KEY_VAL_NEW): *\K"([^"]*")' | sed 's/"//g')" 

sec_val="$(echo $vault_creds | grep -Po '"usr1_val": *\K"([^"]*")' | sed 's/"//g')"

echo Secret Key: $sec_key 
echo Secret Value: $sec_val

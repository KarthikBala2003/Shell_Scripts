#!/bin/bash
# ================================================================================================
vault_creds=`cat ./response/vault_response.json`
# echo "$vault_creds"

USR_KEY=usr1_key
USR_VAL=usr1_val

function get_vault_cred ()
{
	sec_key="$(echo $vault_creds| grep -Po '"'$1'": *\K"([^"]*")' | sed 's/"//g')"
	sec_val="$(echo $vault_creds| grep -Po '"'$2'": *\K"([^"]*")' | sed 's/"//g')"
	return 0
}    

get_vault_cred "$USR_KEY" "$USR_VAL"

echo $sec_key
echo $sec_val
# ======================================= Global Array ========================================

# Global array
declare -A AssociativeArray
declare -a NumericArray

AssociativeArray[Var1]="Var1"
AssociativeArray[Var2]="Var2"

Test="Var5"
if [ "S{AssociativeArray[$Test]}" ]; then
	echo "$Test exists"
else
	echo "$Test does not exists"
fi

# Numeric array
NumericArray+=("All Work")
NumericArray+=("Completed")
NumericArray+=("by end of this week")

echo "Writing the output to a file..."
echo
printf "%s\n" "${NumericArray[@]}" > test.txt

echo "Reading the output from the file text.txt"
cat test.txt
# =================================== Local Array =========================================
# Local Array
foo () {
	local -a LoacalArray
	
	LocalArray[0]="Hi"
	LocalArray[5]="Hello"
	LocalArray[8]=235
	
	echo "${LocalArray[0]} ${LocalArray[5]}"
	echo "Local Array: ${LocalArray[@]}"
}

foo
# ================================================================================================


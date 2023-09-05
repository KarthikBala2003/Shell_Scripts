#!/bin/bash
filename=$0
number_of_params=$#

echo "filename is ${filename}"
echo
echo  "number of parameters passed: ${number_of_params}"
echo

echo param1: "${1}" param2: "${2}" param3: "${3}"
echo

list_args() 
	{ 
		for arg in "${@}" 
		do
			echo "${arg}"
		done
	}

list_args my name is Karthik Bala

# =============================================================================================================================
# ITERATIONS=3  # How many times to get input.
# icount=1

# my_read () {
  # #  Called with my_read varname,
  # #+ outputs the previous value between brackets as the default value,
  # #+ then asks for a new value.

  # local local_var

  # echo -n "Enter a value "
  # eval 'echo -n "[$'$1'] "'  #  Previous value.
# # eval echo -n "[\$$1] "     #  Easier to understand,
                             # #+ but loses trailing space in user prompt.
  # read local_var
  # [ -n "$local_var" ] && eval $1=\$local_var

  # # "And-list": if "local_var" then set "$1" to its value.
# }

# echo

# while [ "$icount" -le "$ITERATIONS" ]
# do
  # my_read var
  # echo "Entry #$icount = $var"
  # let "icount += 1"
  # echo
# done  

# =============================================================================================================================

# echo_var ()
# {
	# echo "$1"
# }

# message=Hello
# Hello=Goodbye

# echo_var "$message"        # Hello
# # Now, let's pass an indirect reference to the function.
# echo_var "${!message}"     # Goodbye

# =============================================================================================================================

# awk '{
  # n = split($0, t, "|")
  # for (i = 0; ++i <= n;)
    # print i, t[i]
  # }' <<<'12|23|11'
  
# =============================================================================================================================

# file=./vault_response.json
# for i in `cat $file`
# do
	# echo "$i"
# done

# =============================================================================================================================


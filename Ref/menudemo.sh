! /usr/bin/env bash

echo "Hello World"

declare HOST_INTERFACE=

function host_interfaces() {

    local -a arr=($(ls 'D:\VirtualBox\VirtualBox VMs'))

    echo "${#arr[@]}"

    if [ "${#arr[@]}" -eq 1 ]; then
        HOST_INTERFACE="${arr[0]}"
        return 0
    fi
    
local opt=
    HOST_INTERFACE=
    echo "Multiple devices detected, please select one from the list:"
    PS3='Please enter your choice: '
    # Add "Quit" value to the items
    select opt in "${arr[@]}" Quit; do
        # "opt" does not contains the number but the associated value
        case $opt in
            "Quit")
                # 
                break
            ;;
            "")
                # No value found
                echo "invalid option"
            ;;
            *)
                echo "You have selected device $opt"
                export HOST_INTERFACE=$opt
                break
            ;;
        esac
    done
}


host_interfaces
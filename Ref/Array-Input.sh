#!/bin/bash
array=( $@ )
len=${#array[@]}
_args=${array[@]:0:$len}
echo "${_args}"
# sudo http_proxy="http://user:password@server:port" apt-get $_args
#!/bin/bash

case "$1" in
	"check" | "install" | "uninstall")
		echo "Did you mean 'dockerd-rootless-setuptool.sh $@' ?"
		exit 1
		;;
esac
if ! [ -w $HOME ]; then
	echo "HOME needs to be set and writable"
	exit 1
fi
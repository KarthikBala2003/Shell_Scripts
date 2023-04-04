#!/bin/bash

# Display running OS name
case "$OSTYPE" in
  solaris*) echo "SOLARIS" ;;
  darwin*)  echo "OSX" ;;
  linux*)   echo "LINUX" ;;
  bsd*)     echo "BSD" ;;
  msys*)    echo "WINDOWS" ;;
  cygwin*)  echo "Git Bash WINDOWS" ;;
  *)        echo "unknown: $OSTYPE" ;;
esac

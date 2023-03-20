#!/bin/bash
if [ -n $1 ] && (($# == 1)); then
  if [[ $1 =~ [[:digit:]] ]]; then
    echo "Incorrect input, digits are not allowed!"
  else
    echo $1
  fi
else
  echo "Enter one string!"
fi

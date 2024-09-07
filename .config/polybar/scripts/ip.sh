#!/bin/sh

internal_ip=$(ip addr | grep 'inet' | awk '/10./ {print $2}')

if [[ ! $internal_ip ]]; then
  echo 0.0.0.0
else
  echo $internal_ip
fi

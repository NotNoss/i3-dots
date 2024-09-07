#!/bin/sh

internal_ip=$(ip addr | grep 'inet' | awk '/10./ {print $2}')

echo $internal_ip

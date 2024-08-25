#!/bin/sh

wallpapers="~/dots/wallpapers/"

while true; do
  feh --randomize --bg-fill $wallpapers
  sleep $1
done

#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
polybar i3-one 2>&1 | tee -a /tmp/polybar.log & disown
polybar i3-two 2>&1 | tee -a /tmp/polybar.log & disown
polybar i3-three 2>&1 | tee -a /tmp/polybar.log & disown
polybar i3-four 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched..."

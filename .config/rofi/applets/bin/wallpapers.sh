#!/bin/bash -x

dir="/home/$USER/Documents/wallpaper/"
cd $dir
wallpaper="none is selected"
set="feh --bg-fill"
view="feh"
startup_config_file="$HOME/.config/i3/config.bak"
theme="/home/$USER/.config/rofi/applets/type-1/style-1.rasi"

kill_process() {
  proc="$(ps -A | grep "feh")"

  if [[ $proc == "" ]]; then
    exit
  else
    killall feh
    exit
  fi
}

selectpic() {
  wallpaper=$(ls $dir | rofi -dmenu -p "select a wallpaper" -theme ${theme})

  if [[ $wallpaper == "q" || $wallpaper == "" ]]; then
    kill_process
  else
    action
  fi
}

action() {
  whattodo=$(echo -e "view\nset\nset (permanant)" | rofi -dmenu -p "whatcha wanna do with it? ($wallpaper)" -theme ${theme})
  if [[ $whattodo == "set" ]]; then
    set_wall
  elif [[ $whattodo == "set (permanant)" ]]; then
    set_permanant
  else
    view_wall
  fi
}

set_wall() {
  $set $wallpaper && kill_process
}

view_wall() {
  $view $wallpaper &
  set_after_view
}

set_after_view() {
  setorno=$(echo -e "set (permanant)\ngo back" | rofi -dmenu -p "wanna set it? ($wallpaper)")

  if [[ $setorno == "set (permanant)" ]]; then
    set_permanant
  else
    wch && kill_process
  fi
}

set_permanant() {
  echo "test"
  set_wall
  sed -i "59s|.*|exec --no-startup-id feh --bg-fill ${dir}${wallpaper}" $startup_config_file
}

selectpic

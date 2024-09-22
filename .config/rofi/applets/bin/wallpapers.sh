#!/bin/bash

dir="$HOME/Documents/wallpaper/"
cd $dir
wallpaper="none is selected"
set="feh --bg-fill"
view="feh"
startup_config_file="$HOME/.config/i3/config"
theme="$HOME/.config/rofi/applets/type-1/style-1.rasi"

selectpic() {
  wallpaper=$(ls $dir | rofi -dmenu -p "select a wallpaper" -theme ${theme})

  if [[ $wallpaper == "q" || $wallpaper == "" ]]; then
    exit
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
  $set $wallpaper
}

view_wall() {
  $view $wallpaper
  set_after_view
}

set_after_view() {
  setorno=$(echo -e "set (permanant)\ngo back" | rofi -dmenu -p "wanna set it? ($wallpaper)")

  if [[ $setorno == "set (permanant)" ]]; then
    set_permanant
  else
    wch
  fi
}

set_permanant() {
  set_wall
  line_to_edit="$(cat $startup_config_file | grep "feh")"
  sed -i "s|$line_to_edit|exec --no-startup-id feh --bg-fill ${dir}${wallpaper}|g" $startup_config_file
}

selectpic

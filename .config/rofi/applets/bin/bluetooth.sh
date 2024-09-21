#!/bin/sh

# Import Current Theme
source "$HOME/.config/rofi/applets/shared/theme.bash"
theme="$type/$style"
themeFile="$HOME/.config/rofi/applets/type-1/style-1.rasi"
devices="none"
name="none"
mac="none"

# Theme Elements
if [[ ( "$theme" == *'type-1'* ) || ( "$theme" == *'type-3'* ) || ( "$theme" == *'type-5'* ) ]]; then
	list_col='1'
	list_row='6'
elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
	list_col='6'
	list_row='1'
fi

layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
if [[ "$layout" == 'NO' ]]; then
	option_1="󰂱 Scan"
	option_2=" Manage"
	option_3="⏻ Power"
	yes=' Yes'
	no=' No'
else
	option_1="󰂱"
	option_2=""
	option_3="⏻"
	yes=''
	no=''
fi

check_power() {
  echo -e "$(bluetoothctl show | grep "PowerState:" | awk '{print $2}')"
}

powerStatus="$(check_power)"
toggle_power() {
  if [[ $powerStatus == "on" ]]; then
    bluetoothctl power off
    return 0
  else
    bluetoothctl power on
    return 0
  fi
}

prompt="Bluetooth"
mesg="Bluetooth is currently $powerStatus"

rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "󰂯";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${theme}
}

run_rofi() {
  echo -e "$option_1\n$option_2\n$option_3" | rofi_cmd
}

confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
		-theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme ${theme}
}

confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Confirm and execute
confirm_run () {	
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
        ${1} && ${2} && ${3}
    else
        exit
    fi	
}

connect_devices() {
  mac=$(echo -e $devices | awk '{print $3}')

  bluetoothctl pair $mac
  bluetoothctl trust $mac
  bluetoothctl connect $mac
}

list_devices() {
  devices=$(bluetoothctl -t 10 scan on | grep "Device" | awk '{print $4 " - " $3}' | rofi -dmenu -p "select a device" -theme ${themeFile})

  if [[ $devices == "q" || $devices == "" ]]; then
    exit
  else
    connect_devices
  fi
}

check_connected() {
  check=$(bluetoothctl devices Connected | grep "$name" | awk '{print $3}')

  if [[ check == $name ]]; then
    echo "connected"
  else
    echo "disconnected"
  fi

  
}

connect_bt_device() {
  bluetoothctl connect $mac
}

disconnect_bt_device() {
  bluetoothctl disconnect $mac
}

forget_bt_device() {
  bluetoothctl disconnect $mac
  bluetoothctl untrust $mac
  bluetoothctl remove $mac
}

block_bt_device() {
  bluetoothctl disconnect $mac
  bluetoothctl untrust $mac
  bluetoothctl remove $mac
  bluetoothctl block $mac
}

device_menu() {
  connected=$(check_connected)
  connect="none"

  echo $connected

  if [[ connected == "connected" ]]; then
    connect="disconnect"
  elif [[ connected == "disconnected" ]]; then
    echo "why"
    connect="connect"
  fi

  options="$connect\nforget\nblock"

  choice=$(echo -e $options | rofi -dmenu -p "select an option" -theme ${themeFile})

  case $choice in
    "connect")
      connect_bt_device
      ;;
    "disconnect")
      disconnect_bt_device
      ;;
    "forget")
      forget_bt_device
      ;;
    "block")
      block_bt_device
      ;;
    *)
      echo "The program ended with an error"
      ;;
  esac
}

list_paired() {
  devices=$(bluetoothctl devices Trusted | grep "Device" | awk '{print $3}' | rofi -dmenu -p "select a device" -theme ${themeFile})

  if [[ $devices == "q" || $devices == "" ]]; then
    exit
  else
    name=$(echo -e bluetoothctl devices Trusted | grep $devices | awk '{print $3}')
    mac=$(echo -e bluetoothctl devices Trusted | grep $devices | awk '{print $2}')
    device_menu
  fi
}

chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
      list_devices
        ;;
    $option_2)
      list_paired
        ;;
    $option_3)
      confirm_run toggle_power
        ;;
esac

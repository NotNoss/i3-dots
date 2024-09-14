#!/bin/sh

# Clone the dot files
git clone https://github.com/NotNoss/i3-dots.git ~/i3-dots

# cd into repo
cd ~/i3-dots/

# Install packages
#yay -S $(cat packages.txt)

# Check for conflicting files
if [ -d "~/.config/i3/" ]; then
  rm -rf ~/.config/i3/
fi

if [ -d "~/.config/kitty/" ]; then
  rm -rf ~/.config/kitty/
fi

if [ -d "~/.config/ohmyposh/" ]; then
  rm -rf ~/.config/ohmyposh/
fi

if [ -d "~/.config/picom/" ]; then
  rm -rf ~/.config/picom/
fi

if [ -d "~/.config/polybar/" ]; then
  rm -rf ~/.config/i3/
fi

if [ -d "~/.config/rofi/" ]; then
  rm -rf ~/.config/rofi/
fi

if [ -d "~/.config/tmux/" ]; then
  rm -rf ~/.config/tmux/
fi

if [ -d "~/.config/xborders/" ]; then
  rm -rf ~/.config/xborders/
fi

if [ -d "~/.themes/" ]; then
  rm -rf ~/.config/.themes/
fi

if [ -d "~/Documents/wallpaper/" ]; then
  rm -rf ~/Documents/wallpaper/
fi

if [ -f "~/.zshrc" ]; then
  rm -rf ~/.zshrc/
fi

# Create sym links
stow .

# Install flatpaks
flatpak install flathub io.github.zen_browser.zen
flatpak install flathub com.usebottles.bottles
flatpak install flathub com.github.tchx84.Flatseal
flatpak install flathub net.davidotek.pupgui2

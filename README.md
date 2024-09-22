## i3wm dot files

# Applications
- [Rofi](https://wiki.archlinux.org/title/Rofi) - I use [rofi-wayland](https://archlinux.org/packages/extra/x86_64/rofi-wayland/) since I use sway and i3. My rofi config is a modified version of [this](https://github.com/adi1090x/rofi)
- [Polybar](https://wiki.archlinux.org/title/Polybar) - modified version of [this config](https://github.com/EndeavourOS-Community-Editions/polybar/tree/main/tokyo-night-by-bitterhalt)
- [i3](https://wiki.archlinux.org/title/I3)
- [BetterLockScreen](https://github.com/betterlockscreen/betterlockscreen)
- [Kitty](https://wiki.archlinux.org/title/Kitty)
- [Tmux](https://wiki.archlinux.org/title/Tmux)
- [OhMyPosh](https://ohmyposh.dev/)
- [ZSH](https://wiki.archlinux.org/title/Zsh)
- [Picom](https://aur.archlinux.org/packages/picom-ft-udev)

# Install Script
The install script (install.sh) is still under development. I can not confirm that it is working or not. Please keep in mind that the install script as of now assumes this is a fresh install and removes any conflicting dot files. It installs everything that I currently use as  this is my dots. I might make it more of a customized install later for the fun of it if I want.

# Setup
```bash
git clone https://github.com/NotNoss/i3-dots.git
cd i3-dots
stow .
```

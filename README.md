# arch-linux-config
My personal configuration for ArcoLinux using BSPWM and Polybar as building blocks.

# About
Operating System: ArcoLinux
- Window Manager: bspwm
- Hotkey manager: sxhkd
- dmenu launcher: rofi
- Notification server: dunst
- Audio manager: pipewire-pulse

# Pre-requirements
This script have been tested only on ArcoLinux so this distro is a must.
Also you need to install BSPWM from ArcoLinux Tweak Tool and make sure SDDM is enabled (Is enabled by default).

# Installation
Just clone and run, easy as that (Or that is what I'm pretending to do)
```
git clone https://github.com/Raniwis/arch-linux-config ~/Documents/
cd ~/Documents/arch-linux-config/
./instal_dependencies.sh
```
Use stow to install the remaining dotfiles

*DO NOT* run copy_files.sh. This script is deprecated.

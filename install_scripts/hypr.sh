#!/bin/bash

# Install Hyprutils
echo '[hypr] Installing Hyprutils...'
mkdir .tmp
git clone https://github.com/hyprwm/hyprutils.git --depth 1 .tmp/hyprutils
cd .tmp/hyprutils
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build
cd ../..

# Install dependencies
echo '[hypr] Installing dependencies...'
if ! pacman -Q hyprlang hyprcursor hyprwayland-scanner libdecor cliphist &>/dev/null; then
  sudo pacman -S hyprlang hyprcursor hyprwayland-scanner libdecor cliphist
fi
# Install Aquamarine
echo '[hypr] Installing Aquamarine...'
git clone https://github.com/hyprwm/aquamarine --depth 1 .tmp/aquamarine
cd .tmp/aquamarine
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build
cd ../..

# Install Hyprland
echo '[hypr] Installing Hyprland...'
git clone --recursive https://github.com/hyprwm/Hyprland --depth 1 .tmp/Hyprland
cd .tmp/Hyprland
make all && sudo make install
cd ../..

# Install Hyprpaper
git clone https://github.com/hyprwm/hyprpaper --depth 1 .tmp/hyprpaper
cd .tmp/hyprpaper
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprpaper -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install ./build
cd ../..

# Add to list of sessions
echo '[hypr] Adding to list of sessions...'
sudo mkdir -p /usr/share/wayland-sessions/
echo "[Desktop Entry] \nName=Hyprland \nComment=This session launches Hyprland \nExec=hyprland \nType=Application" | sudo tee /usr/share/wayland-sessions/hyprland.desktop

# Cleanup
echo '[hypr] Cleaning up...'
rm -rf .tmp

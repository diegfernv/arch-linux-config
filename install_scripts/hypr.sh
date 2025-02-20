#!/bin/bash

PKG_PACMAN=$(tr '\n' ' ' < pacman_packages | xargs)
PKG_YAY=$(tr '\n' ' ' < yay_packages | xargs)

# Install dependencies
echo '[hypr] Installing dependencies...'

if ! pacman -Q "$PKG_YAY" &> /dev/null; then
    yay -S --needed $PKG_YAY
fi
if ! pacman -Q "$PKG_PACMAN" &> /dev/null; then
    sudo pacman -S --needed $PKG_PACMAN
fi

# Install Hyprutils
echo '[hypr] Installing Hyprutils...'
mkdir .tmp
git clone https://github.com/hyprwm/hyprutils.git --depth 1 .tmp/hyprutils
cd .tmp/hyprutils
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build
cd ../..

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
echo '[hypr] Do you want to add Hyprland to the list of sessions? [Y/N]'
read add_session
case $add_session in
    [Yy]* )
        echo '[hypr] Adding to list of sessions...'
        sudo mkdir -p /usr/share/wayland-sessions/
        echo -e "[Desktop Entry]\nName=Hyprland\nComment=This session launches Hyprland\nExec=hyprland\nType=Application" | sudo tee /usr/share/wayland-sessions/hyprland.desktop
        ;;
    [Nn]* )
        echo '[hypr] Skipping...'
        ;;
    * ) echo '[hypr] Do you want to add Hyprland to the list of sessions? [Y/N]' ;;
esac

# Nvidia fix
echo '[hypr] Do you want to apply the Nvidia fix? [Y/N]'
read nvidia_fix
case $nvidia_fix in
    [Yy]* )
        echo '[hypr] Applying Nvidia fix...'
        # Edit /etc/mkinitcpio.conf
        sudo sed -i 's/^MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
        # Create /etc/modprobe.d/nvidia.conf
        echo 'options nvidia_drm modeset=1 fbdev=1' | sudo tee /etc/modprobe.d/nvidia.conf
        # Regenerate initramfs
        sudo mkinitcpio -P
        echo '[hypr] Nvidia fix applied! Please reboot your system.'
        ;;
    [Nn]* )
        echo '[hypr] Skipping...'
        ;;
    * ) echo '[hypr] Do you want to apply the Nvidia fix? [Y/N]' ;;
esac

# Cleanup
echo '[hypr] Cleaning up...'
rm -rf .tmp

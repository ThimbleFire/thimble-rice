#!/bin/bash

# Update package db
sudo pacman -Syu --noconfirm

# Install rust and cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs

# Install packages from official repos
sudo pacman -S --noconfirm vim git htop dolphin rofi neofetch sdl3

# Install AUR helper (yay) if not already installed 
if !command -v yay &> /dev/null; then
  git clone http://aur.archlinux.org/yay-git
  cd yay-git
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
fi

# If sdl3 isn't out yet, install sdl2
if !command -v sdl &> /dev/null; then
  sudo pacman -S --noconfirm sdl2
fi

# Install Rofi (extra)
git clone --depth=1 https://github.com/adi1090x/rofi.git
cd rofi
chmod +x setup.sh
bash setup.sh
cd ~

# Wallpaper manager
git clone https://github.com/LGFae/swww
cd swww
cargo build --release
echo "Put both binaries target/release/swww and target/release/swww-daemon in your path."

yay -S --noconfirm brave-bin arc steam alacritty

# Sensors
git clone https://github.com/Fred78290/nct6687d
cd nct6687d
make install

# Install fan software
echo "Install fan software? (y/n)"
read fan_response
if [[ "$fan_response" == "y" ]]; then
  git clone http://www.github.com/EightB1ts/uni-sync
  cd uni-sync
  bash install.sh
else
  echo "skipping fan installation."

# Install liquid cooler software
echo "Install liquid cooler software? (y/n)"
read liquid_response
if [[ "$liquid_response" == "y" ]]; then
  sudo yay -S liquidctl-git
else
  echo "skipping liquid cooler installation."

# Install liquid cooler software
echo "Install Wine (for Jagex Launcher)? (y/n)"
read jagex_response
if [[ "$jagex_response" == "y" ]]; then
  sudo pacman -S --noconfirm wine-staging winetricks giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox
  winetricks dotnet48
else
  echo "skipping liquid cooler installation."

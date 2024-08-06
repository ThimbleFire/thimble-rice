#!/bin/bash

# Update package db
sudo pacman -Syu --noconfirm

# Install rust and cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs

# Install packages from official repos
sudo pacman -S --noconfirm vim git htop dolphin rofi

# Install AUR helper (yay) if not already installed 
if !command -v yay &> /dev/null; then
  git clone http://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ~
  rm -rf yay
fi

# Install Rofi (extra)
git clone --depth=1 https://github.com/adi1090x/rofi.git
cd rofi
chmod +x setup.sh
bash setup.sh

# Wallpaper manager
git clone https://github.com/LGFae/swww
cd swww
cargo build --release
echo "Put both binaries target/release/swww and target/release/swww-daemon in your path."

yay -S --noconfirm brave-bin arc steam alacritty

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

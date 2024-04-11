#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -eq 0 ]]; then
  echo "Please do not run this script as root, run it as a regular user." 2>&1
  exit 1
fi
# Enable multilib repository
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
# Enable parallel downloading
sudo sed -i 's/#CleanMethod = KeepInstalled/CleanMethod = KeepInstalled/' /etc/yay.conf

# Update system and install essential tools
sudo pacman -Syu --noconfirm base-devel git

# Install yay AUR Helper
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si --noconfirm
cd ..
rm -rf yay-git

# Making .config and Moving config files and background to Pictures
username=$(id -u -n 1000)
builddir=$(pwd)
mkdir -p "/home/$username/.config"
mkdir -p "/home/$username/.fonts"
mkdir -p "/home/$username/Pictures"
mkdir -p /usr/share/sddm/themes
cp .Xresources "/home/$username"
cp .Xnord "/home/$username"
cp -R dotconfig/* "/home/$username/.config/"
cp bg.jpg "/home/$username/Pictures/"
mv user-dirs.dirs "/home/$username/.config"
sudo chown -R "$username:$username" "/home/$username"
tar -xzvf sugar-candy.tar.gz -C /usr/share/sddm/themes
mv "/home/$username/.config/sddm.conf" /etc/sddm.conf

# Installing sugar-candy dependencies
yay -S --noconfirm qt5-svg qt5-declarative
# Installing Essential Programs 
yay -S --noconfirm feh bspwm sxhkd kitty rofi polybar picom thunar lxpolkit xorg-xbacklight unzip yad wget pulseaudio pavucontrol
# Installing Other less important Programs
yay -S --noconfirm neofetch flameshot psmisc mangohud vim papirus-icon-theme sddm

# Download Nordic Theme
cd /usr/share/themes/ || exit
git clone https://github.com/EliverLara/Nordic.git

# Installing fonts
cd "$builddir" || exit
yay -S --noconfirm ttf-font-awesome
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d "/home/$username/.fonts"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d "/home/$username/.fonts"
mv dotfonts/fontawesome/otfs/*.otf "/home/$username/.fonts/"
sudo chown "$username:$username" "/home/$username/.fonts/"*

# Reloading Font
fc-cache -vf
# Removing zip Files
rm FiraCode.zip Meslo.zip

# Install Nordzy cursor
git clone https://github.com/alvatip/Nordzy-cursors
cd Nordzy-cursors || exit
./install.sh
cd "$builddir" || exit
rm -rf Nordzy-cursors

# Install brave-browser
yay -Sy brave-bin --noconfirm

# Enable graphical login and change target from CLI to GUI
sudo systemctl enable sddm
sudo systemctl set-default graphical.target

# Beautiful bash
git clone https://github.com/ChrisTitusTech/mybash
cd mybash || exit
bash setup.sh
cd "$builddir" || exit

# Polybar configuration
bash scripts/changeinterface

# Use yay
bash scripts/useyay

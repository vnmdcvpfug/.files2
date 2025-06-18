#!/bin/bash
set -e
echo -e "\ndotfiles"
echo -e "Welcome to the installation script."
echo -e "It will install the dotfiles and configure the system."
echo -e "Please note that this script can delete files that are important to you. Use with caution."
echo -en "This script is intended for a freshly installed Arch Linux system. Proceed? [y/N] "; read choice_proceed

if [ "$choice_proceed" ] || [ "y" ] || [ "Y" ] || [ "yes" ] || [ "Yes" ] || [ "YES" ]; then
  cd

  echo -e "\nConfiguring the system..."
  sudo ln -sf $HOME/.files/.bashrc $HOME/.bashrc
  sudo ln -sf $HOME/.files/.xinitrc $HOME/.xinitrc
  mkdir -p $HOME/.config/gtk-3.0
  echo "[Settings]
  gtk-application-prefer-dark-theme=1" > $HOME/.config/gtk-3.0/settings.ini
  for folder in "$HOME/.files/.config/"*; do
    sudo ln -sf $folder $HOME/.config/$(basename $folder)
  done

  echo -e "\nInstalling the scripts..."
  sudo mkdir -p /usr/bin
  for file in "$HOME/.files/bin/"*; do
    sudo ln -sf $file /usr/bin/$(basename $file)
  done

  echo -e "\nConfiguring the battery and brightness control..."
  echo 'user ALL=(ALL) NOPASSWD: /usr/bin/tee /sys/class/backlight/intel_backlight/brightness' | sudo tee -a /etc/sudoers
  sudo touch /etc/systemd/system/batteryctl.service
  sudo echo "[Unit]
Description=Set battery charge thresholds
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/bin/sh -c 'echo 70 | tee /sys/class/power_supply/BAT1/charge_start_threshold'
ExecStart=/bin/sh -c 'echo 80 | tee /sys/class/power_supply/BAT1/charge_stop_threshold'
RemainAfterExit=true

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/batteryctl.service > /dev/null
  sudo systemctl enable --now batteryctl.service

  echo -e "\nInstalling the packages..."
  sudo pacman -S bluez bluez-utils chromium i3wm noto-fonts noto-fonts-cjk noto-fonts-emoji ollama neovim ranger ripgrep xdg-desktop-portal-gtk wezterm zathura zathura-pdf-mupdf

  echo -en "\nThe installation is complete. Would you like to start i3? [Y/n] "; read choice_i3
else
  exit 0
fi

if [ "$choice_i3" ] || [ "y" ] || [ "Y" ] || [ "yes" ] || [ "Yes" ] || [ "YES" ] || [ "" ]; then
  cd
  startx
else
  exit
fi

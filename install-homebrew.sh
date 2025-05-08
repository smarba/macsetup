#!/bin/zsh

# Install Homebrew (this will automatically add Homebrew to the PATH)
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed."
fi
 # Wait for user to complete the installation
echo "Read Homebrew installation information.  Do you need to copy info into env or zshrc?"
read "REPLY?Press [Enter] once Homebrew installation has completed..."

# Install Git, Ansible, mas, and zsh-syntax-highlighting
echo "Installing brew packages..."
echo "Installing Git, Ansible, mas, and zsh-syntax-highlighting..."
brew install \
  git \
  ansible \
  zsh-syntax-highlighting \
  imagemagick \
  mas

#Install homebrew casks
echo "Installing Homebrew casks..."
brew install --cask \
  visual-studio-code \
  1password \
  tailscale \
  dropbox \
  zoom \
  microsoft-office-businesspro \
  adobe-acrobat-pro \
  mpv \
  vlc
  


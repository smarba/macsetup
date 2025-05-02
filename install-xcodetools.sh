#!/bin/zsh

# Check if Xcode Command Line Tools are already installed
if xcode-select -p &>/dev/null; then
  echo "Xcode Command Line Tools are already installed."
else
  echo "Xcode Command Line Tools are not installed."
  # Install Xcode Command Line Tools
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install

  # Wait for user to complete the installation
  read "REPLY?Press [Enter] once Xcode Command Line Tools installation has completed..."
fi

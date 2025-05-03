#!/bin/zsh

# Install Homebrew (this will automatically add Homebrew to the PATH)
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed."
fi


# Install Git, Ansible, mas, and zsh-syntax-highlighting
echo "Installing brew packages..."
echo "Installing Git, Ansible, mas, and zsh-syntax-highlighting..."
brew install git ansible zsh-syntax-highlighting mas
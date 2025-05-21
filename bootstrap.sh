#!/bin/zsh

#########################################################
# This bootstrap.sh script is designed to get the bare  #
# necessitites on the machine before ansible playbooks  #
# with homebrew and git can finish the job              #
#                                                       #
# Version 1.0                                           #
# Commit Date: 5/20/2025                                #
#                                                       #
#                                                       #
#########################################################


set -euo pipefail

#################################
# Functions                     #
#################################

# Function to ensure a line exists in .zshrc
ensure_zshrc_line() {
  local line="$1"
  grep -qxF "$line" ~/.zshrc || echo "$line" >> ~/.zshrc
}

ensure_zprofile_line() {
  local line="$1"
  grep -qxF "$line" ~/.zprofile || echo "$line" >> ~/.zprofile
}

echo "📦 Installing Xcode Command Line Tools (if needed)..."
xcode-select --install 2>/dev/null || echo "✅ Xcode tools already installed"

echo "🍺 Installing Homebrew (if needed)..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to PATH (especially needed on Apple Silicon)
echo "🔧 Ensuring Homebrew is in PATH..."
if [[ -d "/opt/homebrew/bin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
elif [[ -d "/usr/local/bin" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
  echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
fi

echo "🍺 Updating and installing essential packages..."
brew update
brew install git ansible
brew install --cask 1password

#Prompt telling the user to log into 1Password GUI and connect SSH-Agent
read "REPLY?Press [Enter] once iPassword installation has completed and you are logged in"

echo "🔄 Enabling op ssh-agent integration..."
eval "$(op ssh-agent)"
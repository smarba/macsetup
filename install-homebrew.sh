#!/bin/zsh

# Install Homebrew if not already present
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "Read Homebrew installation information. Do you need to copy info into env or zshrc?"
  read "REPLY?Press [Enter] once Homebrew installation has completed..."
else
  echo "Homebrew is already installed."
fi

# ── Formulae ──────────────────────────────────────────────────────────────────
echo "Installing Homebrew formulae..."
brew install \
  git \
  ansible \
  imagemagick \
  mas \
  1password-cli \
  zsh-autosuggestions \
  zsh-syntax-highlighting \
  eza \
  bat \
  fd \
  ripgrep \
  fzf \
  gh \
  zoxide \
  starship

# ── Casks ─────────────────────────────────────────────────────────────────────
echo "Installing Homebrew casks..."
brew install --cask \
  font-jetbrains-mono-nerd-font \
  visual-studio-code \
  1password \
  tailscale \
  dropbox \
  zoom \
  microsoft-office-businesspro \
  mpv \
  vlc \
  expressvpn \
  dockdoor \
  linearmouse

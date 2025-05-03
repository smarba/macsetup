#!/bin/zsh

echo "Setting executable permissions for scripts..."
./determine-chmod.sh
echo "Permissions set."

#Set hostname
echo "Setting hostname..."
source set-hostname.sh
echo "Hostname set applied."

#Install XCode Command Line Tools
echo "Installing Xcode Command Line Tools..."
./install-xcodetools.sh

: <<'XcodeInstall'
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
XcodeInstall

#Enable WebInterface for CUPS
echo "Enabling WebInterface for CUPS..."
cupsctl WebInterface=Yes



read "REPLY?Press [Enter] once once the printer is added..."

echo "Now go and set the default options for the printer."
open "http://localhost:631/printers"

#Install homebrew and associated packages
echo "Installing homebrew and associated packages..."
./install-homebrew.sh

:<<'HomebrewInstall'
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
HomebrewInstall

# Check if SSH key exists
if [ -f ~/.ssh/id_ed25519 ]; then
  echo "An existing SSH key was found at ~/.ssh/id_ed25519. Skipping key generation."
else
  echo "Generating SSH key with default options and location..."
  ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
fi


# Check if the key is already added to the agent
ssh-add -l | grep -q "$(ssh-keygen -lf ~/.ssh/id_ed25519 | awk '{print $2}')"
if [ $? -ne 0 ]; then
  echo "Adding SSH key to agent..."
  ssh-add ~/.ssh/id_ed25519
else
  echo "SSH key is already loaded in the agent."
fi



# Display the public SSH key for the user to copy
echo "Your SSH key has been generated. Copy the following public key and add it to GitHub:"
echo "Public key location: ~/.ssh/id_ed25519.pub"
cat ~/.ssh/id_ed25519.pub
echo
# Pause to allow user to copy the SSH public key and add it to GitHub
read "REPLY?Press [Enter] after adding your SSH key to GitHub..."

# Test SSH connection to GitHub
echo "Testing SSH connection to GitHub..."
ssh -T git@github.com
if [ $? -ne 0 ]; then
  echo "SSH connection to GitHub failed. Please check your SSH key and GitHub settings."
  exit 1
else
  echo "SSH connection to GitHub successful!"
fi

# Setup .gitconfig file

# Set Git user name and email
echo "Setting up Git configuration..."
echo "Setting username and email..."
git config --global user.name "Seth Abrams"
git config --global user.email "smarba@gmail.com"

# Set default editor
echo "Setting default editor to nano..."
git config --global core.editor "nano"

# Enable color UI
echo "Enabling color UI..."
git config --global color.ui auto

# Set default branch name when running `git init`
echo "Setting default branch name to 'main'..."
git config --global init.defaultBranch main

# Set up default push settings
echo "Setting default push behavior to 'simple'..."
git config --global push.default simple




# Now you can clone repositories
echo "You can now clone your GitHub repositories using SSH!"

#####Set Up .ZSHRC#####
echo "Setting up .zshrc..."
# Check if .zshrc already exists
if [ -f ~/.zshrc ]; then
  echo ".zshrc already exists. Skipping creation."
else
  echo "Creating .zshrc..."
  touch ~/.zshrc
fi


# Custom Zsh Configuration
ZSHRC="$HOME/.zshrc"

# Append core ZSH config
cat << 'EOF' >> "$ZSHRC"

# === Custom ZSH Enhancements ===

# Enable up/down arrow history prefix search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# Case-insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Show completion menu immediately
zstyle ':completion:*' menu select

# Use vi keybindings (Not being used for now)
# bindkey -v
EOF

# Append syntax highlighting if installed
echo "Checking for zsh-syntax-highlighting in .zshrc file..."
if ! grep -q "zsh-syntax-highlighting" "$ZSHRC"; then
  echo "Appending zsh-syntax-highlighting to .zshrc..."
  echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$ZSHRC"
else
  echo "zsh-syntax-highlighting already exists in .zshrc. Skipping."
fi

echo "✅ ZSH config updated."

# Distribute SSH Keys to Pis
echo "Distributing SSH keys to Raspberry Pis..."
# Define hosts
hosts=(pi@pi0{1..5} pi@pi07 pi4-08)

# Arrays to hold summary info
successes=()
skipped=()
failures=()

for pi in $hosts; do
  echo "🔄 Processing $pi..."

  if ssh -o BatchMode=yes -o ConnectTimeout=5 "$pi" exit 2>/dev/null; then
    echo "✅ Key already set up for $pi, skipping."
    skipped+=("$pi")
  else
    echo "🚀 Attempting to copy key to $pi..."
    if ssh-copy-id -i ~/.ssh/id_ed25519.pub "$pi" 2>/dev/null; then
      echo "✅ Key successfully copied to $pi."
      successes+=("$pi")
    else
      echo "❌ Failed to copy key to $pi — host might be offline or unreachable."
      failures+=("$pi")
    fi
  fi
done

# Print summary
echo "\n📋 SSH Key Distribution Summary:"
echo "--------------------------------"
echo "✅ Successes:"
for host in $successes; do echo "  - $host"; done

echo "\n⏭️ Skipped (already set up):"
for host in $skipped; do echo "  - $host"; done

echo "\n❌ Failures:"
for host in $failures; do echo "  - $host"; done

#Install Tailscale Standalone
echo "Installing Tailscale Standalone..."
./install-tailscale.sh

:<<'TailscaleInstall'
# Check if Tailscale is already installed
if [ -d "/Applications/Tailscale.app" ]; then
  echo "Tailscale is already installed."
  tailscale_version=$(defaults read /Applications/Tailscale.app/Contents/Info.plist CFBundleShortVersionString) 
  echo "Tailscale version: $tailscale_version"
else
  # Get the latest version URL dynamically
  LATEST_VERSION_URL="https://pkgs.tailscale.com/stable/"
  LATEST_PKG=$(curl -s $LATEST_VERSION_URL | grep -o 'href="[^"]*macos\.pkg"' | sed 's/href="//' | head -n 1)

  # Full URL to the latest package
  TAILSCALE_PKG_URL="https://pkgs.tailscale.com/stable/$LATEST_PKG"
  INSTALL_DIR="/tmp/tailscale"

  # Download the latest Tailscale .pkg file
  echo "Downloading Tailscale package from $TAILSCALE_PKG_URL..."
  curl -L $TAILSCALE_PKG_URL -o /tmp/tailscale.pkg

  # Install the Tailscale package
  echo "Installing Tailscale..."
  sudo installer -pkg /tmp/tailscale.pkg -target /

  # Clean up the downloaded package
  echo "Cleaning up..."
  rm -f /tmp/tailscale.pkg

  # Verify the installation
  echo "Verifying installation..."
  tailscale version

  # Optionally, start the Tailscale service
  echo "Starting Tailscale..."
  sudo tailscale up

  echo "Tailscale installation complete!"
fi
TailscaleInstall



#Install Dropbox
echo "Installing Dropbox..."
# Check if Dropbox is already installed
if [ -d "/Applications/Dropbox.app" ]; then
  echo "Dropbox is already installed."
else
  # Download and install Dropbox
  echo "Downloading Dropbox installer..."
  ./install_dropbox.sh
fi

#Set Custom MacOS Settings
echo "Setting custom MacOS settings..."
source set-preferences.sh
echo "Custom MacOS settings applied."

# Install 1Password
./install-1password.sh


# Install Mac App Store Applications
./install-mas-apps.sh
echo "Mac App Store applications installed."

echo "Please configure / login to:
- 1Password
- Dropbox
- Tailscale
"

echo "All tasks completed."
echo "Please restart your computer for all changes to take effect."

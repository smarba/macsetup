#!/bin/zsh

# Install Xcode Command Line Tools
echo "Installing Xcode Command Line Tools..."
xcode-select --install

# Wait for user to complete the installation
read "REPLY?Press [Enter] once Xcode Command Line Tools installation has completed..."

# Install Homebrew (this will automatically add Homebrew to the PATH)
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed."
fi

# Install Git and Ansible
echo "Installing Git and Ansible..."
brew install git ansible

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

# Pause to allow user to copy the SSH public key and add it to GitHub
echo "Your SSH key has been generated. Please copy your public key to GitHub."
echo "Public key location: ~/.ssh/id_ed25519.pub"

# Display the public SSH key for the user to copy
echo "Your SSH key has been generated. Copy the following public key and add it to GitHub:"
cat ~/.ssh/id_ed25519.pub
echo
read "REPLY?Press [Enter] after adding your SSH key to GitHub..."

# Now you can clone repositories
echo "You can now clone your GitHub repositories using SSH!"

echo "All tasks completed."

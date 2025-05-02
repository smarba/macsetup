#!/bin/zsh

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
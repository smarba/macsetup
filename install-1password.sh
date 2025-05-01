#!/bin/zsh

# Install 1Password from the website
echo "🔐 Starting the installation of 1Password 8 from the official website..."

# Define the URL to download the 1Password 8 .zip installer
ZIP_URL="https://downloads.1password.com/mac/1Password.zip"

# Define the download path (we'll use the Downloads folder)
DOWNLOAD_DIR="$HOME/Downloads"
INSTALLER_ZIP="$DOWNLOAD_DIR/1Password.zip"
EXTRACTED_APP="$DOWNLOAD_DIR/1Password Installer.app"


# Download the 1Password .zip file using curl
echo "⬇️ Downloading the 1Password 8 installer from: $ZIP_URL"
curl -L "$ZIP_URL" -o "$INSTALLER_ZIP"

# Extract the .zip file to the Downloads folder
echo "📦 Extracting the 1Password installer to the Downloads folder..."
unzip -q "$INSTALLER_ZIP" -d "$DOWNLOAD_DIR"

# Open the installer to begin the installation
echo "🚀 Launching the 1Password Installer..."
open "$EXTRACTED_APP"

# Prompt the user to complete the installation manually
echo "🛠️ The 1Password installer has been opened. Please follow the on-screen instructions to complete the installation."

# Wait for user to complete the installation
read "REPLY?⏳ Press [Enter] once you have completed the 1Password installation..."

# Clean up the downloaded zip file and the temporary extracted .app
echo "🧹 Cleaning up the downloaded files..."
rm -f "$INSTALLER_ZIP"
rm -f "$EXTRACTED_APP"

# Confirm installation
if [ -d "/Applications/1Password.app" ]; then
  echo "✅ 1Password 8 has been successfully installed in the Applications folder. You're all set!"
else
  echo "❌ 1Password installation failed. Please check the installer and try again."
fi
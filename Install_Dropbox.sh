#!/bin/zsh

set -euo pipefail

# Variables
DOWNLOAD_FOLDER="$HOME/Downloads/"
DMG_URL="https://www.dropbox.com/download?os=mac&plat=mac"
DMG_FILE="dropbox_installer.dmg"
DMG_PATH="$DOWNLOAD_FOLDER$DMG_FILE"
APP_NAME="Dropbox.app"
MOUNT_POINT="/Volumes/Dropbox Installer"
APP_SOURCE="$MOUNT_POINT/$APP_NAME"
APP_DESTINATION="/Applications/$APP_NAME"

echo "📦 Downloading Dropbox..."
curl -L -o "$DMG_PATH" "$DMG_URL"

echo "📂 Mounting DMG..."
hdiutil attach "$DMG_PATH" -nobrowse -quiet

if [[ -d "$APP_SOURCE" ]]; then
    echo "📥 Installing Dropbox to /Applications..."
    cp -R "$APP_SOURCE" /Applications/
else
    echo "❌ Dropbox.app not found in DMG. Aborting."
    hdiutil detach "$MOUNT_POINT" -quiet
    exit 1
fi

echo "💾 Unmounting DMG..."
hdiutil detach "$MOUNT_POINT" -quiet

echo "🧹 Cleaning up..."
rm -f "$DMG_PATH"

echo "🚀 Launching Dropbox..."
open "$APP_DESTINATION"

echo "✅ Dropbox installed and launched successfully."

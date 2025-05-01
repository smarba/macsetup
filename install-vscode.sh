#!/bin/zsh

###NOT READY.  Link / extraction not functioning yet

APPLICATION_NAME="Visual Studio Code"
DOWNLOAD_URL="https://code.visualstudio.com/sha/download?build=stable&os=darwin-arm64"
ZIP_FILE="$HOME/Downloads/VSCode.zip"
APP_NAME="Visual Studio Code.app"
APP_DESTINATION="$HOME/Downloads/$APP_NAME"

echo "🔐 Starting the installation of $APPLICATION_NAME from the official website..."

# Download the ZIP file
echo "⬇️ Downloading $APPLICATION_NAME ZIP from: $DOWNLOAD_URL"
curl -L "$DOWNLOAD_URL" -o "$ZIP_FILE"

# Check if the downloaded file is a valid ZIP archive
if [[ $(file "$ZIP_FILE") == *"Zip archive data"* ]]; then
    echo "📦 Unzipping the downloaded file..."
    unzip -q "$ZIP_FILE" -d "$HOME/Downloads"

    # Locate the .app file in the extracted contents
    EXTRACTED_APP_PATH=$(find "$HOME/Downloads" -name "$APP_NAME" -type d -maxdepth 2)
    if [[ -d "$EXTRACTED_APP_PATH" ]]; then
        echo "📥 Installing $APPLICATION_NAME to /Applications..."
        mv "$EXTRACTED_APP_PATH" "$APP_DESTINATION"
    else
        echo "❌ $APPLICATION_NAME not found in the extracted contents. Aborting."
        rm -f "$ZIP_FILE"
        exit 1
    fi
else
    echo "❌ The downloaded file is not a valid ZIP archive. Aborting."
    rm -f "$ZIP_FILE"
    exit 1
fi

# Clean up the downloaded ZIP file
echo "🧹 Cleaning up..."
rm -f "$ZIP_FILE"


echo "✅ $APPLICATION_NAME installed successfully!"


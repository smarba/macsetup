#!/bin/zsh
echo
echo
echo

echo "Changing system preferences..."

###############################################################################
# General UI/UX                                                               #
###############################################################################

echo "🔧 Configuring General UI/UX settings..."
echo

# Expand save panel by default
echo "      📂 Expanding save panel by default..."
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
echo "      🖨️  Expanding print panel by default..."
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Save to disk (not to iCloud) by default
echo "      💾 Setting default save location to disk (not iCloud)..."
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
echo "      🖨️  Enabling auto-quit for printer app after jobs complete..."
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
echo

###############################################################################
# Safari                                                                      #
###############################################################################

echo "🌐 Configuring Safari settings (requires sudo)..."
echo

# Run Safari-related commands with sudo
sudo zsh <<EOF
# Enable the Develop menu and the Web Inspector
echo "      🛠️ Enabling Develop menu and Web Inspector..."
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
# Enable the debug menu in Web Inspector
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Turn off all Autofill behaviors in Safari
echo "      🔒 Disabling all Autofill behaviors in Safari..."
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillWebForms -bool false
EOF
echo
###############################################################################
# Screen                                                                      #
###############################################################################

echo "🖥️ Configuring screen settings..."
echo

# Save screenshots to Downloads folder.
echo "      📸 Saving screenshots to Downloads folder..."
defaults write com.apple.screencapture location -string "${HOME}/Downloads"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
echo "      📸 Setting screenshot format to PNG..."
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
echo "      📸 Disabling shadows in screenshots..."
defaults write com.apple.screencapture disable-shadow -bool true
echo
###############################################################################
# Finder                                                                      #
###############################################################################

echo "🔍 Configuring Finder settings..."
echo

# Show hidden files in Finder
echo "      👀 Showing hidden files in Finder..."
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all filename extensions
echo "      📂 Showing all filename extensions..."
defaults write NSGlobalDomain AppleShowAllFiles -bool true

# Show hidden files in Open/Save dialogs
echo "      👀 Showing hidden files in Open/Save dialogs..."
defaults write NSGlobalDomain AppleShowAllFiles -bool true

# Show path bar in Finder
echo "      📍 Enabling path bar in Finder..."
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar in Finder
echo "      📊 Enabling status bar in Finder..."
defaults write com.apple.finder ShowStatusBar -bool true

# Show icons for hard drives, servers, and removable media on the desktop
echo "      💾 Configuring desktop icons for drives and media..."
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
echo "      🏠 Setting $HOME as the default location for new Finder windows..."
defaults write com.apple.finder NewWindowTarget -string "PfHm"
#defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"  ##Deprecated?  Does not appear in defaults read

# When performing a search, search the current folder by default
echo "      🔍 Setting Finder search to current folder by default..."
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
echo "      ⚠️ Disabling warning when changing file extensions..."
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network volumes
echo "      🌐 Preventing .DS_Store files on network volumes..."
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `Nlsv`, `clmv`, `Flwv`
echo "      📂 Setting default Finder view to list view..."
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
echo
############################################################################
# Dock                                                                     #
############################################################################

echo "🛠️ Configuring Dock settings..."
echo
# Set Dock to the left side and vertical
echo "      📐 Moving Dock to the left side..."
defaults write com.apple.dock orientation -string left

# Turn off recent and suggested apps for the Dock
echo "      🚫 Disabling recent and suggested apps in the Dock..."
defaults write com.apple.dock show-recents -bool false

# Set the dock icon size to 50 pixels (64 is default)
echo "      📏 Setting Dock icon size to 45 pixels..."
defaults write com.apple.dock tilesize -int 45
echo
############################################################################
# Mouse / Trackpad Settings                                                #
############################################################################

echo "🖱️ Configuring Mouse and Trackpad settings..."
echo

# Disable natural scrolling (uncheck "Scroll direction: Natural")
echo "      🔄 Disabling natural scrolling..."
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Enable tap to click for trackpad
echo "      👆 Enabling tap-to-click for trackpad..."
# 1. Built-in trackpad (Intel and Apple Silicon)
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
# 2. Bluetooth (e.g., Magic Trackpad)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# 3. System-wide/user preference
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Sets Right Click Behaviors
echo "      🖱️ Configuring right-click behaviors for trackpad..."
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 2
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerSecondaryClick -int 2
echo
############################################################################
# Apply Changes                                                            #
############################################################################

echo "🔄 Applying changes to macOS settings..."
echo

# Resets Dock
echo "♻️ Restarting Dock..."
killall Dock

# Resets Finder
echo "♻️ Restarting Finder..."
killall Finder

# Resets SystemUIServer
echo "♻️ Restarting SystemUIServer..."
killall SystemUIServer

echo "✅ All settings have been applied! Enjoy your customized macOS experience! 🎉"
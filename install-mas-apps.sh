#!/bin/zsh
# Ensure mas is installed
echo "Checking if mas is installed via homebrew..."
if ! command -v mas &> /dev/null; then
  echo "Installing mas..."
  brew install mas
fi

# Ensure the user is signed in
echo "Checking if the user is signed in to the Mac App Store..."
if ! mas account &> /dev/null; then
  echo "Please sign in to the Mac App Store app first."
  exit 1
fi

# Declare associative array (requires zsh, not bash)
typeset -A apps=(
  [1Password for Safari]=1569813296
  [Photomator]=1444636541
  [iStat Menus 7]=6499559693
  [Parcel]=639968404
  [AdBlock fo Safari]=1402042596
  [Flighty]=1358823008
)

for app_name in "${(@k)apps}"; do
  echo "Installing $app_name (ID: ${apps[$app_name]})"
  mas install "${apps[$app_name]}"
done

#!/bin/zsh

# Define the list of scripts
scripts=(
  "set-hostname.sh"
  "install-xcodetools.sh"
#  "install-vscode.sh"
#  "install_dropbox.sh"
#  "install-tailscale.sh"
  "install-mas-apps.sh"
#  "install-1password.sh"
  "set-preferences.sh"
  "install-homebrew.sh"
)

# Base directory where the scripts are located
SCRIPT_DIR="$HOME/macsetup"
SETUP_FILE="$SCRIPT_DIR/setup.sh"

# Only execute the logic below if the script is run directly
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  echo "🔍 Checking which scripts need to be made executable..."

  for script in "${scripts[@]}"; do
    SCRIPT_PATH="$SCRIPT_DIR/$script"

    # Check if the script exists
    if [[ -f "$SCRIPT_PATH" ]]; then
      # Check if the script is referenced for execution (./script.sh)
      if grep -qE "\./$script" "$SETUP_FILE"; then
        echo "⚙️  Making $script executable (referenced for execution)..."
        chmod +x "$SCRIPT_PATH"
      # Check if the script is sourced (source script.sh or . script.sh)
      elif grep -qE "(source|\. )\s+$script" "$SETUP_FILE"; then
        echo "ℹ️  $script is sourced. Skipping chmod."
      else
        echo "❓ $script is neither sourced nor executed. Skipping."
      fi
    else
      echo "❌ $script not found in $SCRIPT_DIR. Skipping."
    fi
  done

  echo "✅ Script processing complete."
fi
#!/bin/zsh

# Prompt user for new hostname
read "raw_name?Enter the new host name: "

# Trim leading/trailing whitespace and normalize internal spaces
raw_name=$(echo "$raw_name" | awk '{$1=$1; print}')

# Remove spaces for HostName and LocalHostName (required by macOS)
clean_name="${raw_name// /}"

# Set the various hostname types
sudo scutil --set HostName "$clean_name"
sudo scutil --set LocalHostName "$clean_name"
sudo scutil --set ComputerName "$raw_name"

# Refresh DNS/mDNS cache
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

# Confirm
echo "✅ Hostnames updated successfully:"
echo "  ComputerName:    $raw_name"
echo "  HostName:        $clean_name"
echo "  LocalHostName:   $clean_name"

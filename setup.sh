#!/bin/bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Install Command Line Tools
echo "Installing macOS Command Line Tools..."
xcode-select --install
echo "✅ CLT installed."

# Install Homebrew (brew.sh)
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo "✅ Homebrew installed."

# Install packages via Homebrew
echo "Installing packages via Homebrew..."
brew bundle
echo "✅ Packages installed."

# Setting shell to fish
echo "Setting default shell to fish"
echo /usr/local/bin/fish >> /etc/shells
chsh -s /usr/local/bin/fish
echo "✅ Shell set. 🐟"

# Keyboard
echo "Setting keyboard settings..."
defaults write com.apple.HIToolbox AppleCurrentKeyboardLayoutInputSourceID -string "com.apple.keylayout.Dvorak"
echo "Keyboard set. ⌨"

# Dock
echo "Setting dock settings..."
# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0
# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0
# Set dock orientation
defaults write com.apple.dock orientation "left"
# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true
# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true
# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true
# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true
defaults write com.apple.dock tilesize 35

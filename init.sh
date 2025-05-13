#!/usr/bin/env bash

set -e

# Init Homebrew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Speed up held down keys
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 20

# Dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# UK PC Keyboard layout
defaults delete com.apple.HIToolbox AppleEnabledInputSources
defaults write com.apple.HIToolbox AppleCurrentKeyboardLayoutInputSourceID -string 'com.apple.keylayout.British-PC'
defaults write com.apple.HIToolbox AppleInputSourceHistory -array-add '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>250</integer><key>KeyboardLayout Name</key><string>British-PC</string></dict>'
defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>250</integer><key>KeyboardLayout Name</key><string>British-PC</string></dict>'
defaults write com.apple.HIToolbox AppleSelectedInputSources -array-add '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>250</integer><key>KeyboardLayout Name</key><string>British-PC</string></dict>'

# Stop iTunes from responding to the keyboard media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

# Disable Show Spotlight search
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/></dict>"

# Move left a space - Ctrl + Left
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 79 "
  <dict>
    <key>enabled</key><true/>
    <key>value</key><dict>
      <key>type</key><string>standard</string>
      <key>parameters</key>
      <array>
        <integer>65535</integer>
        <integer>123</integer>
        <integer>262144</integer>
      </array>
    </dict>
  </dict>
"

# Move right a space - Ctrl + Right
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 81 "
  <dict>
    <key>enabled</key><true/>
    <key>value</key><dict>
      <key>type</key><string>standard</string>
      <key>parameters</key>
      <array>
        <integer>65535</integer>
        <integer>124</integer>
        <integer>262144</integer>
      </array>
    </dict>
  </dict>
"

# Disable Switch to Space 1
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 118 "<dict><key>enabled</key><false/></dict>"
# Disable Switch to Space 2
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 119 "<dict><key>enabled</key><false/></dict>"
# Disable Switch to Space 3
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 120 "<dict><key>enabled</key><false/></dict>"

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Dock: set to right
defaults write com.apple.dock "orientation" -string "right"

# Dock: show only active apps
defaults write com.apple.dock "static-only" -bool "true"

# Dock: autohide
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "autohide-delay" -float "0"
defaults write com.apple.dock "autohide-time-modifier" -float "0.2"

# Raycast: use cmd-Space as shortcut
defaults write com.raycast.macos raycastGlobalHotkey -string "Command-49"

# Start Rectangle on boot (won't work, not installed yet)
# defaults write com.knollsoft.Rectangle launchOnLogin -int 1

# Set Desktop wallpaper
osascript -e 'tell application "System Events" to tell every desktop to set picture to "~/.config/wezterm/Coriolis_Station.png"'

touch ~/.coro.init

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Activity Monitor" \
	"Address Book" \
	"Calendar" \
	"cfprefsd" \
	"Contacts" \
	"Dock" \
	"Finder" \
	"Google Chrome Canary" \
	"Google Chrome" \
	"Mail" \
	"Messages" \
	"Opera" \
	"Photos" \
	"Safari" \
	"SizeUp" \
	"Spectacle" \
	"SystemUIServer" \
	"Terminal" \
	"Transmission" \
	"Tweetbot" \
	"Twitter" \
	"iCal"; do
	killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."

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
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# UK PC Keyboard layout
defaults write com.apple.HIToolbox '{
    AppleCurrentKeyboardLayoutInputSourceID = "com.apple.keylayout.British-PC";
    AppleEnabledInputSources =     (
                {
            "Bundle ID" = "com.apple.CharacterPaletteIM";
            InputSourceKind = "Non Keyboard Input Method";
        },
                {
            "Bundle ID" = "com.apple.PressAndHold";
            InputSourceKind = "Non Keyboard Input Method";
        },
                {
            InputSourceKind = "Keyboard Layout";
            "KeyboardLayout ID" = 250;
            "KeyboardLayout Name" = "British-PC";
        },
                {
            InputSourceKind = "Keyboard Layout";
            "KeyboardLayout ID" = 2;
            "KeyboardLayout Name" = British;
        }
    );
    AppleInputSourceHistory =     (
                {
            InputSourceKind = "Keyboard Layout";
            "KeyboardLayout ID" = 250;
            "KeyboardLayout Name" = "British-PC";
        }
    );
    AppleSelectedInputSources =     (
                {
            "Bundle ID" = "com.apple.PressAndHold";
            InputSourceKind = "Non Keyboard Input Method";
        },
                {
            InputSourceKind = "Keyboard Layout";
            "KeyboardLayout ID" = 250;
            "KeyboardLayout Name" = "British-PC";
        }
    );
}
'

# Stop iTunes from responding to the keyboard media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

# Disable fn/Globe and Caps Lock
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys '{
    118 =         {
        enabled = 0;
        value =             {
            parameters =                 (
                65535,
                18,
                262144
            );
            type = standard;
        };
    };
    119 =         {
        enabled = 0;
        value =             {
            parameters =                 (
                65535,
                19,
                262144
            );
            type = standard;
        };
    };
    120 =         {
        enabled = 0;
        value =             {
            parameters =                 (
                65535,
                20,
                262144
            );
            type = standard;
        };
    };
    15 =         {
        enabled = 0;
    };
    16 =         {
        enabled = 0;
    };
    164 =         {
        enabled = 0;
        value =             {
            parameters =                 (
                65535,
                65535,
                0
            );
            type = standard;
        };
    };
    17 =         {
        enabled = 0;
    };
    18 =         {
        enabled = 0;
    };
    19 =         {
        enabled = 0;
    };
    20 =         {
        enabled = 0;
    };
    21 =         {
        enabled = 0;
    };
    22 =         {
        enabled = 0;
    };
    23 =         {
        enabled = 0;
    };
    24 =         {
        enabled = 0;
    };
    25 =         {
        enabled = 0;
    };
    26 =         {
        enabled = 0;
    };
    60 =         {
        enabled = 0;
        value =             {
            parameters =                 (
                32,
                49,
                262144
            );
            type = standard;
        };
    };
    61 =         {
        enabled = 0;
        value =             {
            parameters =                 (
                32,
                49,
                786432
            );
            type = standard;
        };
    };
    64 =         {
        enabled = 0;
        value =             {
            parameters =                 (
                32,
                49,
                1048576
            );
            type = standard;
        };
    };
    79 =         {
        enabled = 1;
        value =             {
            parameters =                 (
                65535,
                123,
                8650752
            );
            type = standard;
        };
    };
    80 =         {
        enabled = 1;
        value =             {
            parameters =                 (
                65535,
                123,
                8781824
            );
            type = standard;
        };
    };
    81 =         {
        enabled = 1;
        value =             {
            parameters =                 (
                65535,
                124,
                8650752
            );
            type = standard;
        };
    };
    82 =         {
        enabled = 1;
        value =             {
            parameters =                 (
                65535,
                124,
                8781824
            );
            type = standard;
        };
    };
}
'
#
# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Raycast: use cmd-Space as shortcut
defaults write com.raycast.macos raycastGlobalHotkey -string "Command-49"

# Start Rectangle on boot (won't work, not installed yet)
# defaults write com.knollsoft.Rectangle launchOnLogin -int 1

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

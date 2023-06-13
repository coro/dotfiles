#!/usr/bin/env bash

set -e

# Init Homebrew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Speed up held down keys
defaults write 'Apple Global Domain' KeyRepeat -int 1
defaults write 'Apple Global Domain' InitialKeyRepeat -int 10

# Dark mode
defaults write 'Apple Global Domain' AppleInterfaceStyle -string "Dark"

# UK PC Keyboard layout
defaults write com.apple.HIToolbox '{
        AppleCurrentKeyboardLayoutInputSourceID = "com.apple.keylayout.British-PC";
        AppleEnabledInputSources =         (
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
            }
        );
        AppleFnUsageType = 0;
        AppleInputSourceHistory =         (
                        {
                InputSourceKind = "Keyboard Layout";
                "KeyboardLayout ID" = 250;
                "KeyboardLayout Name" = "British-PC";
            },
        );
        AppleSelectedInputSources =         (
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
    }'

# Disable fn/Globe and Caps Lock
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys '{
    15 =     {
        enabled = 0;
    };
    16 =     {
        enabled = 0;
    };
    164 =     {
        enabled = 0;
        value =         {
            parameters =             (
                65535,
                65535,
                0
            );
            type = standard;
        };
    };
    17 =     {
        enabled = 0;
    };
    18 =     {
        enabled = 0;
    };
    19 =     {
        enabled = 0;
    };
    20 =     {
        enabled = 0;
    };
    21 =     {
        enabled = 0;
    };
    22 =     {
        enabled = 0;
    };
    23 =     {
        enabled = 0;
    };
    24 =     {
        enabled = 0;
    };
    25 =     {
        enabled = 0;
    };
    26 =     {
        enabled = 0;
    };
    60 =     {
        enabled = 0;
    };
    61 =     {
        enabled = 0;
    };
    79 =     {
        enabled = 1;
    };
    80 =     {
        enabled = 1;
    };
    81 =     {
        enabled = 1;
    };
    82 =     {
        enabled = 1;
    };
}'

# Start Rectangle on boot (won't work, not installed yet)
# defaults write com.knollsoft.Rectangle launchOnLogin -int 1

touch ~/.coro.init

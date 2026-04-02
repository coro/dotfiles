{ pkgs, ... }:

{
  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages (needed for some casks)
  nixpkgs.config.allowUnfree = true;

  # System version (set once on initial install, do not change)
  system.stateVersion = 6;

  # Primary user (required for system.defaults, homebrew, etc.)
  system.primaryUser = "connor.rogers";

  # Declare the user (needed by home-manager's darwin integration)
  users.users."connor.rogers" = {
    name = "connor.rogers";
    home = "/Users/connor.rogers";
  };

  # Enable sudo with TouchID
  security.pam.services.sudo_local.touchIdAuth = true;

  # macOS system defaults
  system.defaults = {
    NSGlobalDomain = {
      KeyRepeat = 1;
      InitialKeyRepeat = 20;
      AppleInterfaceStyle = "Dark";
      AppleShowAllExtensions = true;
    };

    dock = {
      orientation = "right";
      static-only = true;
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.2;
    };

    finder = {
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
      ShowStatusBar = true;
      ShowPathbar = true;
    };
  };

  # Preferences that don't have dedicated nix-darwin options
  system.activationScripts.postActivation.text = ''
    # UK PC Keyboard layout
    defaults delete com.apple.HIToolbox AppleEnabledInputSources 2>/dev/null || true
    defaults write com.apple.HIToolbox AppleCurrentKeyboardLayoutInputSourceID -string 'com.apple.keylayout.British-PC'
    defaults write com.apple.HIToolbox AppleInputSourceHistory -array-add '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>250</integer><key>KeyboardLayout Name</key><string>British-PC</string></dict>'
    defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>250</integer><key>KeyboardLayout Name</key><string>British-PC</string></dict>'
    defaults write com.apple.HIToolbox AppleSelectedInputSources -array-add '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>250</integer><key>KeyboardLayout Name</key><string>British-PC</string></dict>'

    # Stop iTunes from responding to the keyboard media keys
    launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2>/dev/null || true

    # Disable Spotlight search hotkey
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

    # Disable Switch to Space 1-3
    defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 118 "<dict><key>enabled</key><false/></dict>"
    defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 119 "<dict><key>enabled</key><false/></dict>"
    defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 120 "<dict><key>enabled</key><false/></dict>"

    # Raycast: use cmd-Space as shortcut
    defaults write com.raycast.macos raycastGlobalHotkey -string "Command-49"

    # Set Desktop wallpaper
    osascript -e 'tell application "System Events" to tell every desktop to set picture to "~/.config/wezterm/Coriolis_Station.png"' && killall Dock 2>/dev/null || true
  '';

  # Homebrew (for GUI apps / casks only)
  homebrew = {
    enable = true;
    taps = [
      "wez/wezterm"
    ];
    casks = [
      "font-jetbrains-mono-nerd-font"
      "raycast"
      "rectangle"
      "wez/wezterm/wezterm"
      "wireshark-app"
      "tableplus"
    ];
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}

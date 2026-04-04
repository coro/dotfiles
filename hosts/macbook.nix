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

  # Raycast hotkey (declarative via CustomUserPreferences)
  system.defaults.CustomUserPreferences."com.raycast.macos" = {
    raycastGlobalHotkey = "Command-49";
  };

  # Preferences that don't have dedicated nix-darwin options
  system.activationScripts.postActivation.text = ''
    # UK PC Keyboard layout (ID 250 = British-PC)
    defaults delete com.apple.HIToolbox AppleEnabledInputSources 2>/dev/null || true
    defaults write com.apple.HIToolbox AppleCurrentKeyboardLayoutInputSourceID -string 'com.apple.keylayout.British-PC'
    defaults write com.apple.HIToolbox AppleInputSourceHistory -array '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>250</integer><key>KeyboardLayout Name</key><string>British-PC</string></dict>'
    defaults write com.apple.HIToolbox AppleEnabledInputSources -array '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>250</integer><key>KeyboardLayout Name</key><string>British-PC</string></dict>'
    defaults write com.apple.HIToolbox AppleSelectedInputSources -array '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>250</integer><key>KeyboardLayout Name</key><string>British-PC</string></dict>'

    # Stop iTunes/Music from responding to media keys
    launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2>/dev/null || true

    # Symbolic hotkey IDs: https://web.archive.org/web/20141112224103/http://hintsforums.macworld.com/showthread.php?t=114785
    # Parameter array: [ASCII code (65535=none), virtual keycode, modifier flags]
    # Modifier flags: 262144=Ctrl, 524288=Option, 1048576=Cmd, 131072=Shift

    # Hotkey 64: Spotlight search — disable (replaced by Raycast)
    defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/></dict>"

    # Hotkey 79: Move left a space — Ctrl+Left (keycode 123)
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

    # Hotkey 81: Move right a space — Ctrl+Right (keycode 124)
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

    # Hotkeys 118-120: Switch to Space 1-3 — disable (frees Ctrl+1/2/3)
    defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 118 "<dict><key>enabled</key><false/></dict>"
    defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 119 "<dict><key>enabled</key><false/></dict>"
    defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 120 "<dict><key>enabled</key><false/></dict>"

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

{ pkgs, config, ... }:

let
  dotfilesPath = "${config.home.homeDirectory}/workspace/dotfiles";
in

{
  imports = [
    ./shell.nix
    ./git.nix
  ];

  home.username = "connor.rogers";
  home.homeDirectory = "/Users/connor.rogers";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    # Core tools
    gnupg
    neovim
    ripgrep
    luajit
    mise
    uv
    yazi
    pinentry_mac
    claude-code
    tree-sitter
    nerd-fonts.jetbrains-mono
    kubectx

    # LSPs
    gopls
    pyright
    lua-language-server
    terraform-ls
    clojure-lsp
    yaml-language-server

    # Formatters
    stylua
    black
    gofumpt
    yamlfmt
    cljfmt

    # Linters
    golangci-lint
    pylint
    luajitPackages.luacheck
    yamllint
    tflint
    clj-kondo
  ];

  # Neovim config (kept as-is, managed by vim.pack)
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/config/nvim";

  # Wezterm config (kept as-is)
  xdg.configFile."wezterm".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/config/wezterm";

  # Claude Code config (symlink individual files to keep auto-generated state untouched)
  home.file.".claude/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/config/claude/settings.json";

  # Mise config (global tool versions)
  xdg.configFile."mise".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/config/mise";

  # GPG agent config (interpolates the correct pinentry-mac path from Nix store)
  home.file.".gnupg/gpg-agent.conf".text = ''
    pinentry-program ${pkgs.pinentry_mac}/bin/pinentry-mac
  '';
}

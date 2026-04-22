{ pkgs, lib, config, ... }:

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
    yq-go

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

  # Serena: install/upgrade via uv
  home.activation.serenaInstall = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ${pkgs.uv}/bin/uv tool install -p 3.13 serena-agent@latest --prerelease=allow --upgrade 2>/dev/null || true
  '';

  # Serena: register MCP server with Claude Code (idempotent)
  home.activation.serenaMcp = lib.hm.dag.entryAfter [ "serenaInstall" ] ''
    if ! run ${pkgs.claude-code}/bin/claude mcp list 2>/dev/null | grep -q serena; then
      run ${pkgs.claude-code}/bin/claude mcp add --scope user serena -- \
        serena start-mcp-server --context claude-code --project-from-cwd
    fi
  '';

  # Serena: config (preserve projects list from existing file, override everything else)
  home.activation.serenaConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    SERENA_CFG="$HOME/.serena/serena_config.yml"
    SERENA_SRC="${dotfilesPath}/config/serena/serena_config.yml"
    PROJECTS_TMP=$(mktemp)
    mkdir -p "$HOME/.serena"
    if [ -f "$SERENA_CFG" ]; then
      run ${pkgs.yq-go}/bin/yq '.projects // []' "$SERENA_CFG" > "$PROJECTS_TMP"
    else
      echo '[]' > "$PROJECTS_TMP"
    fi
    run cp "$SERENA_SRC" "$SERENA_CFG"
    run ${pkgs.yq-go}/bin/yq -i ".projects = load(\"$PROJECTS_TMP\")" "$SERENA_CFG"
    rm -f "$PROJECTS_TMP"
  '';

  # GPG agent config (interpolates the correct pinentry-mac path from Nix store)
  home.file.".gnupg/gpg-agent.conf".text = ''
    pinentry-program ${pkgs.pinentry_mac}/bin/pinentry-mac
  '';
}

# dotfiles

Declarative macOS configuration using [nix-darwin](https://github.com/nix-darwin/nix-darwin) and [Home Manager](https://github.com/nix-community/home-manager).

## What's managed

- **System**: macOS defaults (Dock, Finder, keyboard, etc.)
- **Packages**: CLI tools, LSPs, formatters, linters via nixpkgs
- **GUI apps**: Casks via Homebrew (managed declaratively by nix-darwin)
- **Shell**: zsh, fzf, starship
- **Git**: config, signing, aliases, LFS
- **GPG**: agent config with pinentry-mac
- **Neovim**: config symlinked as-is (plugins managed by vim.pack, LSPs/formatters/linters via nix)
- **Wezterm**: config symlinked as-is

## Prerequisites

- macOS (Apple Silicon)
- [Nix](https://nixos.org/download/) (multi-user install)

## First-time setup

1. Install Nix:

   ```sh
   sh <(curl -L https://nixos.org/nix/install) --daemon
   ```

2. Clone this repo:

   ```sh
   git clone https://github.com/coro/dotfiles.git ~/workspace/dotfiles
   cd ~/workspace/dotfiles
   ```

3. Build and activate:

   ```sh
   sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin/master#darwin-rebuild -- switch --flake .#macbook
   ```

   On subsequent runs (or via the shell alias):

   ```sh
   rebuild
   ```

## Day-to-day usage

| Task | Command |
|------|---------|
| Apply config changes | `rebuild` (shell alias) |
| Update all packages | `nix flake update && rebuild` |
| Update nixpkgs only | `nix flake update nixpkgs && rebuild` |
| Roll back | `sudo darwin-rebuild switch --rollback` |
| Reclaim disk space | `nix-collect-garbage -d` |

## Structure

```
flake.nix              # Nix flake entry point (inputs + wiring)
hosts/macbook.nix      # macOS system defaults, Homebrew casks
home/
  default.nix          # Packages, dotfile symlinks, GPG
  shell.nix            # zsh, fzf, starship
  git.nix              # Git config, signing, aliases
config/
  nvim/                # Neovim config (vim.pack, treesitter)
  wezterm/             # Wezterm config + cyberdream theme
starship.toml          # Starship prompt config (consumed by home/shell.nix)
```

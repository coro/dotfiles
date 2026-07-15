# Global instructions

## LSP and code intelligence

- **Prefer Serena for LSP-based actions.** Use Serena's tools (`find_symbol`,
  `find_referencing_symbols`, `get_symbols_overview`, `replace_symbol_body`,
  `get_diagnostics_for_file`, etc.) for symbol lookup, references, navigation,
  and semantic edits whenever a language server can answer the question, instead
  of raw text search or manual editing. Serena is already configured as an MCP
  server in this environment.
- **For any other LSP work Serena can't cover, use the language servers already
  installed on `PATH`.** These are provided by this dotfiles' home-manager
  config. Do not fall back to Claude Code's embedded LSPs, and do not prompt to
  install a language server when one is already available.

## Installing tools just-in-time

- **When a tool isn't already available and you need it for a task, prefer
  `nix-shell` to bring it into scope** — e.g. `nix-shell -p <pkg> --run '...'`,
  or `nix run nixpkgs#<pkg> -- ...`. Reach for Nix before Homebrew, `pip
  install`, `npm install -g`, or other global installers, so the tool stays
  ephemeral and doesn't pollute the system.
- **Always ask the user to confirm before installing or running a tool this
  way.** State which package you want and why, and wait for approval before
  invoking it.

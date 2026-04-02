{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      vim = "nvim";
      k = "kubectl";
      killdns = "sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder";
      rebuild = "sudo darwin-rebuild switch --flake ~/workspace/dotfiles#macbook";
    };

    completionInit = ''
      zstyle ':completion:*:*:make:*' tag-order 'targets'
    '';

    profileExtra = ''
      if [ -d "/opt/homebrew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';

    initContent = ''
      export GPG_TTY="$(tty)"
      command -v go &>/dev/null && export PATH="$PATH:$(go env GOPATH)/bin"
      [[ $commands[kubectl] ]] && source <(kubectl completion zsh)

      [ -f ~/.zshrc.local ] && source ~/.zshrc.local
      [ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

      function coauth() {
        git shortlog --summary --numbered --email --all . | \
        cut -f2- | \
        awk '$0="Co-authored-by: "$0' | \
        fgrep -v "$(git config user.email)" | \
        fzf --multi --exit-0 --no-sort \
          --bind 'tab:toggle+down,shift-tab:toggle+up' \
          --header 'Use TAB to select multiple authors, ENTER to confirm' | \
        pbcopy
      }

      function gitsize() {
        git rev-list --objects --all \
          | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
          | sed -n 's/^blob //p' \
          | sort --numeric-sort --key=2 \
          | tail -n 20 \
          | cut -c 1-12,41- \
          | $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
      }

      function kbuild() {
        kustomize build "$1" --enable-helm --load-restrictor LoadRestrictionsNone
      }
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = builtins.fromTOML (builtins.readFile ../starship.toml);
  };
}

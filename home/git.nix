{ ... }:

{
  programs.git = {
    enable = true;

    signing = {
      key = "396E4C3347A28C63";
      signByDefault = true;
      format = "openpgp";
    };

    lfs.enable = true;

    settings = {
      user = {
        name = "Connor Rogers";
        email = "23215294+coro@users.noreply.github.com";
      };
      alias = {
        co = "checkout";
        st = "status";
      };
      core.editor = "nvim";
      init.defaultBranch = "main";
      pull.rebase = true;
      merge.conflictstyle = "zdiff3";
    };
  };
}

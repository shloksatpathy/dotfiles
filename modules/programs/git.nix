{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName = "shloksatpathy";
    userEmail = "shloke1504@gmail.com";

    aliases = {
      st = "status -sb";
      co = "checkout";
      br = "branch";
      lg = "log --oneline --graph --decorate";
    };

    extraConfig = {
      init.defaultBranch = "main";

      pull.rebase = false;

      fetch.prune = true;

      push.autoSetupRemote = true;

      core.editor = "nvim";

      color.ui = "auto";
    };
  };
}

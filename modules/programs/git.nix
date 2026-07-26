{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName = "shloksatpathy";
    userEmail = "shloke1504@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";

      pull.rebase = false;

      fetch.prune = true;

      push.autoSetupRemote = true;

      core.editor = "code --wait";

      color.ui = "auto";
    };
  };
}

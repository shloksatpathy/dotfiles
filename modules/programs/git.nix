{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.name = "shloksatpathy";
      user.email = "shloke1504@gmail.com";

      alias = {
        st = "status -sb";
        co = "checkout";
        br = "branch";
        lg = "log --oneline --graph --decorate";
      };

      init.defaultBranch = "main";

      pull.rebase = false;

      fetch.prune = true;

      push.autoSetupRemote = true;

      core.editor = "nvim";

      color.ui = "auto";
    };
  };
}

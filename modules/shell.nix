{ pkgs, ... }:

{
  home.sessionPath = [
    "$HOME/.npm-global/bin"
  ];

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 100000;
      save = 100000;
      ignoreDups = true;
      ignoreSpace = true;
    };

    shellAliases = {
      ls = "eza";
      ll = "eza -lah";
      la = "eza -a";

      cat = "bat";

      grep = "rg";

      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
    };
  };
}

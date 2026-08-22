{ ... }:

{
  home.sessionPath = [
    "$HOME/.npm-global/bin"
  ];

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # This machine's /etc/zsh/zprofile is missing the `source /etc/profile`
    # line Debian/Ubuntu normally ships, so /etc/profile.d/nix.sh never runs
    # for zsh and no session gets nix on PATH. Source Nix's own profile script
    # here instead: .zshenv is read on every zsh invocation (login, non-login,
    # interactive and scripts), and the script self-guards against re-running.
    # It sets NIX_PROFILES too, which .zshrc needs to add nix packages'
    # completions to fpath.
    envExtra = ''
      if [[ -z "''${NIX_PROFILES-}" ]]; then
        if [[ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
          . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        elif [[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
          . "$HOME/.nix-profile/etc/profile.d/nix.sh"
        fi
      fi
    '';

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

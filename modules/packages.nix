{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wget
    curl
    unzip
    zip

    tree
    eza
    bat
    fd
    ripgrep
    fzf
    zoxide

    btop
    htop

    jq
    yq-go

    fastfetch
  ];
}

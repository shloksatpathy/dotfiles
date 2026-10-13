{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gcc
    cmake
    gnumake

    python3
    uv

    rustup

    gh
    lazygit
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}

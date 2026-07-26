{ config, pkgs, ... }:

{
  imports = [
    ../../modules/packages.nix
    ../../modules/fonts.nix
    ../../modules/git.nix
    ../../modules/shell.nix
    ../../modules/terminal.nix
    ../../modules/development.nix
    ../../modules/environment.nix
    ../../modules/desktop.nix
  ];

  home.username = "shlok";
  home.homeDirectory = "/home/shlok";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}

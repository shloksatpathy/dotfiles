{ config, pkgs, ... }:

{
 imports = [
  ../../modules/packages.nix
  ../../modules/fonts.nix
  ../../modules/shell.nix
  ../../modules/development.nix
  ../../modules/environment.nix
  ../../modules/desktop.nix

  ../../modules/programs/git.nix
  ../../modules/programs/starship.nix
  ../../modules/programs/neovim.nix
  ../../modules/programs/fzf.nix
  ../../modules/programs/wezterm.nix
  ../../modules/programs/zoxide.nix
]; 

  home.username = "shlok";
  home.homeDirectory = "/home/shlok";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}

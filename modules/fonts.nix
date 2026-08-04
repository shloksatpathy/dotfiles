{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.hack

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];
}

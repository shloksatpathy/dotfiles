{ pkgs, ... }:

{
  home.packages = with pkgs; [

    zsh
    neovim

    nodejs_22
    wget
    curl
    unzip
    zip

    xclip
    wl-clipboard

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

    # Neovim language servers and formatters (used by lua/plugins/lsp.lua, format.lua)
    clang-tools
    pyright
    ruff
    lua-language-server
    nil
    stylua
    nixfmt-rfc-style
  ];
}

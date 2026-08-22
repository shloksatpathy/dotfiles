# Dotfiles

Personal development environment managed with Nix + Home Manager, targeting **Ubuntu 24.04 LTS**.

## Stack

- Nix / Home Manager (`flake.nix`, `nixos-25.05` / `home-manager-25.05`)
- Zsh (autosuggestions, syntax highlighting, Starship prompt, zoxide, fzf)
- Git
- WezTerm
- Neovim (Lazy.nvim, Treesitter)

## Layout

```
flake.nix              # entry point, defines homeConfigurations.ideapad
hosts/ideapad/home.nix # host-specific config, imports modules below
modules/                # home-manager modules
  packages.nix          # CLI packages (zsh, neovim, ripgrep, eza, bat, fd, fzf, ...)
  fonts.nix              # Nerd Fonts + Noto fonts
  shell.nix               # zsh setup
  development.nix, environment.nix, desktop.nix  # placeholders, not yet configured
  programs/              # per-program modules (git, starship, neovim, fzf, wezterm, zoxide, terminal)
home/.config/           # dotfiles symlinked in by the programs/ modules
  nvim/                  # Neovim config (Lua, Lazy.nvim)
  wezterm/               # WezTerm config
scripts/, lib/, wallpapers/  # currently empty, reserved for future use
```

## Usage

```sh
home-manager switch --flake .#ideapad
```

## Status

🚧 Under construction — `development.nix`, `environment.nix`, `desktop.nix`, and `programs/terminal.nix` are stubs pending configuration.

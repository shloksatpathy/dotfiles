# Dotfiles

Personal development environment managed with Nix + Home Manager, targeting **Ubuntu 24.04 LTS** (`x86_64-linux`).

## Stack

- **Nix / Home Manager**: `flake.nix`, pinned to `nixos-25.05` / `home-manager release-25.05`
- **Zsh**: completion, autosuggestions, syntax highlighting, Starship prompt, zoxide, fzf
- **Git**: identity and defaults (`main` default branch, auto-prune, auto-setup remote on push)
- **WezTerm**: modular Lua config (appearance, fonts, keys, launch)
- **Neovim**: Lazy.nvim, Treesitter, Rosé Pine (moon) colorscheme
- **Clipboard**: `xclip` (X11) and `wl-clipboard` (Wayland)
- **Fonts**: Hack Nerd Font, Noto (incl. CJK and emoji)

## Layout

```
flake.nix                # entry point, defines homeConfigurations.ideapad
hosts/ideapad/home.nix   # host config: user, stateVersion, module imports
modules/                 # home-manager modules
  packages.nix           # CLI packages (see below)
  fonts.nix              # Nerd Fonts + Noto fonts
  shell.nix              # zsh setup, aliases, history, Nix PATH fix
  development.nix, environment.nix, desktop.nix  # stubs, not yet configured
  programs/              # per-program modules
    git.nix, starship.nix, fzf.nix, zoxide.nix   # enabled via home-manager
    neovim.nix, wezterm.nix                      # symlink configs from home/.config
    terminal.nix                                 # stub
home/.config/            # raw config files symlinked into ~/.config
  nvim/                  # init.lua, lua/config/*, lua/plugins/*
  wezterm/               # wezterm.lua, config/*
```

## Packages

| Category   | Packages |
|------------|----------|
| Core       | zsh, neovim, nodejs_22 |
| Network    | wget, curl |
| Archives   | zip, unzip |
| Clipboard  | xclip, wl-clipboard |
| Files      | tree, eza, bat, fd, ripgrep, fzf, zoxide |
| Monitoring | btop, htop |
| Data       | jq, yq-go |
| Misc       | fastfetch |

## Shell

Aliases defined in `modules/shell.nix`:

| Alias | Command |
|-------|---------|
| `ls`, `ll`, `la` | `eza`, `eza -lah`, `eza -a` |
| `cat` | `bat` |
| `grep` | `rg` |
| `..`, `...`, `....` | go up 1, 2, or 3 directories |

`~/.npm-global/bin` is added to `PATH` for global npm installs.

Nix is loaded from `.zshenv` on every zsh session. This machine's `/etc/zsh/zprofile` doesn't source `/etc/profile`, so without this step Nix would never be on `PATH`.

## WezTerm

- Launches `zsh -l` in a 120×32 window
- `Alt+Enter` toggles fullscreen (default keybindings are kept)

## Usage

Prerequisites: Nix installed with flakes enabled.

```sh
git clone <repo-url> ~/dotfiles
cd ~/dotfiles

# first run (home-manager not yet installed)
nix run home-manager/release-25.05 -- switch --flake .#ideapad

# subsequent runs
home-manager switch --flake .#ideapad
```

To update pinned inputs:

```sh
nix flake update
home-manager switch --flake .#ideapad
```

## Notes

- Git's `core.editor` is set to `code --wait`, so VS Code needs to be installed separately.
- WezTerm itself isn't installed by this flake. Only its config is managed here.

## Status

🚧 Under construction. `development.nix`, `environment.nix`, `desktop.nix`, and `programs/terminal.nix` are stubs pending configuration.

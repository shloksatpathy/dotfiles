# Dotfiles

Personal development environment managed with Nix + Home Manager, targeting **Ubuntu 24.04 LTS** (`x86_64-linux`).

## Stack

- **Nix / Home Manager**: `flake.nix`, pinned to `nixos-25.05` / `home-manager release-25.05`
- **Zsh**: completion, autosuggestions, syntax highlighting, Starship prompt, zoxide, fzf
- **Git**: identity and defaults (`main` default branch, auto-prune, auto-setup remote on push, Neovim as the commit editor)
- **WezTerm**: modular Lua config (appearance, fonts, keys, launch)
- **Neovim**: Lazy.nvim, Treesitter, LSP, completion, formatting, fzf-lua, Rosé Pine (moon) colorscheme
- **Development**: gcc, CMake, Make, Python with uv, rustup, `gh`, lazygit, direnv with nix-direnv
- **Desktop**: GNOME shortcuts, wallpaper and lock screen settings via dconf
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
  desktop.nix            # GNOME via dconf: keybindings, wallpaper, lock screen
  development.nix        # toolchains, gh, lazygit, direnv
  environment.nix        # EDITOR, VISUAL, PAGER, XDG
  programs/              # per-program modules
    git.nix, starship.nix, fzf.nix, zoxide.nix   # enabled via home-manager
    neovim.nix, wezterm.nix                      # symlink configs from home/.config
home/.config/            # raw config files symlinked into ~/.config
  nvim/                  # init.lua, lua/config/*, lua/plugins/*
  wezterm/               # wezterm.lua, config/*
wallpapers/              # wallpaper.jpg, used for the desktop and lock screen
Makefile                 # switch, update and check targets
.github/workflows/       # CI: builds the Home Manager config on every push to main
PLAN.md                  # roadmap
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
| Neovim tooling | clang-tools, pyright, ruff, lua-language-server, nil, stylua, nixfmt-rfc-style |
| Build      | gcc, cmake, gnumake |
| Python     | python3, uv |
| Rust       | rustup |
| Git tools  | gh, lazygit |

`direnv` with `nix-direnv` is enabled in `modules/development.nix`.

## Shell

Aliases defined in `modules/shell.nix`:

| Alias | Command |
|-------|---------|
| `ls`, `ll`, `la` | `eza`, `eza -lah`, `eza -a` |
| `cat` | `bat` |
| `..`, `...`, `....` | go up 1, 2, or 3 directories |

`~/.npm-global/bin` is added to `PATH` for global npm installs.

Nix is loaded from `.zshenv` on every zsh session. This machine's `/etc/zsh/zprofile` doesn't source `/etc/profile`, so without this step Nix would never be on `PATH`.

`modules/environment.nix` sets `EDITOR` and `VISUAL` to `nvim`, `PAGER` to `bat --plain`, `MANPAGER` to render man pages through `bat`, and enables XDG base directories.

Git aliases defined in `modules/programs/git.nix`: `st`, `co`, `br`, `lg`.

## WezTerm

- Launches `zsh -l` in a 120×32 window
- `Alt+Enter` toggles fullscreen (default keybindings are kept)

## Neovim

Plugins live in `home/.config/nvim/lua/plugins/`, one file per concern. Leader is `Space`.

| File | Provides |
|------|----------|
| `fzf.lua` | fzf-lua: `<leader>ff` files, `fg` grep, `fb` buffers, `fh` help, `fr` resume |
| `lsp.lua` | nvim-lspconfig for clangd, pyright, ruff, lua_ls, nil_ls; `gd`, `gD`, `<leader>d` |
| `completion.lua` | blink.cmp |
| `format.lua` | conform.nvim, formats on save; `<leader>cf` formats manually |
| `ui.lua` | oil.nvim (`-`), gitsigns, lualine, which-key |

Language servers and formatters come from Nix (`modules/packages.nix`), not Mason. The config directory is a read-only Nix store symlink, so `lazy-lock.json` is kept in `~/.local/share/nvim/` instead. Flakes only see git-tracked files, so `git add` new config files before running `home-manager switch`.

## Desktop shortcuts

GNOME custom keybindings are declared in `modules/desktop.nix` through `dconf.settings`. Home Manager owns the whole custom keybinding list, so any new shortcut has to be added there, not through GNOME Settings.

| Shortcut | Action |
|----------|--------|
| `Ctrl+Alt+Space` | Launch WezTerm |
| `Super+L` | Lock the screen (GNOME's built-in action; also locks after 5 minutes idle) |
| `Ctrl+Shift+M` | Toggle Do Not Disturb (flips `show-banners` and WezTerm's per-app notification switch, because WezTerm toasts such as Claude Code's still showed with banners off) |

## Wallpaper and lock screen

Put the image at `wallpapers/wallpaper.jpg` (and `git add` it). `modules/desktop.nix` copies it to `~/.local/share/wallpapers/` and sets it as the desktop and lock screen background.

## Usage

Prerequisites: Nix installed with flakes enabled.

```sh
git clone git@github.com:shloksatpathy/dotfiles.git ~/dotfiles
cd ~/dotfiles

# first run (home-manager not yet installed)
nix run home-manager/release-25.05 -- switch --flake .#ideapad

# subsequent runs
home-manager switch --flake .#ideapad
```

After the first run, the `Makefile` covers the usual commands:

```sh
make switch   # apply the config
make update   # update pinned inputs (run make switch afterwards)
make check    # build the config without activating it
```

## Notes

- WezTerm itself isn't installed by this flake. Only its config is managed here.
- herdr handles terminal multiplexing. It's installed separately with `nix profile` from its own flake, and its config in `~/.config/herdr/` isn't managed here.

## Status

🚧 Under construction. Remaining work is tracked in `PLAN.md`.

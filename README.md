# Dotfiles

Personal development environment managed with Nix + Home Manager, targeting **Ubuntu 24.04 LTS** (`x86_64-linux`).

## Stack

- **Nix / Home Manager**: `flake.nix`, pinned to `nixos-26.05` / `home-manager release-26.05`
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
| Neovim tooling | clang-tools, pyright, ruff, lua-language-server, nil, stylua, nixfmt |
| Build      | gcc, cmake, gnumake |
| Python     | python3, uv |
| Rust       | rustup |
| Git tools  | gh, lazygit |

`direnv` with `nix-direnv` is enabled in `modules/development.nix`.

## Tools

### Environment and terminal

| Tool | What it does | Usage | Links |
|------|--------------|-------|-------|
| Nix | Reproducible package manager; flakes pin every input | `nix flake update`, `nix build` | [website](https://nixos.org) · [repo](https://github.com/NixOS/nix) |
| Home Manager | Declares user packages and dotfiles with Nix | `make switch` | [website](https://nix-community.github.io/home-manager/) · [repo](https://github.com/nix-community/home-manager) |
| WezTerm | GPU-accelerated terminal, configured in Lua | `Ctrl+Alt+Space` to launch | [website](https://wezterm.org) · [repo](https://github.com/wezterm/wezterm) |
| herdr | Terminal workspace manager for AI coding agents; used instead of tmux | `herdr` to launch or attach, `herdr status` | [website](https://herdr.dev) · [repo](https://github.com/herdrdev/herdr) |
| Zsh | Login shell | Configured in `modules/shell.nix` | [website](https://www.zsh.org) · [repo](https://github.com/zsh-users/zsh) |
| zsh-autosuggestions | Suggests commands from history as you type | `→` accepts a suggestion | [repo](https://github.com/zsh-users/zsh-autosuggestions) |
| zsh-syntax-highlighting | Colours commands as you type | Automatic | [repo](https://github.com/zsh-users/zsh-syntax-highlighting) |
| Starship | Shell prompt | Automatic; `starship explain` describes the prompt | [website](https://starship.rs) · [repo](https://github.com/starship/starship) |
| Neovim | Editor; also `EDITOR` and the git commit editor | `nvim file`, `:Lazy` for plugins | [website](https://neovim.io) · [repo](https://github.com/neovim/neovim) |

### Command line

| Tool | What it does | Usage | Links |
|------|--------------|-------|-------|
| eza | `ls` replacement | `ls`, `ll`, `la` | [website](https://eza.rocks) · [repo](https://github.com/eza-community/eza) |
| bat | `cat` replacement with syntax highlighting; also the pager | `cat file` | [repo](https://github.com/sharkdp/bat) |
| fd | Fast `find` alternative | `fd name` | [repo](https://github.com/sharkdp/fd) |
| ripgrep | Fast recursive search | `rg pattern` | [repo](https://github.com/BurntSushi/ripgrep) |
| fzf | Fuzzy finder | `Ctrl+R` history, `Ctrl+T` files, `Alt+C` directories | [website](https://junegunn.github.io/fzf/) · [repo](https://github.com/junegunn/fzf) |
| zoxide | `cd` that remembers frequent directories | `z name`, `zi` to pick interactively | [repo](https://github.com/ajeetdsouza/zoxide) |
| tree | Prints directory trees | `tree -L 2` | [website](https://oldmanprogrammer.net/source.php?dir=projects/tree) · [repo](https://github.com/Old-Man-Programmer/tree) |
| jq | JSON processor | `jq '.name' package.json` | [website](https://jqlang.org) · [repo](https://github.com/jqlang/jq) |
| yq | YAML processor | `yq '.jobs' file.yml` | [repo](https://github.com/mikefarah/yq) |
| btop | Resource monitor | `btop` | [repo](https://github.com/aristocratos/btop) |
| htop | Process viewer | `htop` | [website](https://htop.dev) · [repo](https://github.com/htop-dev/htop) |
| fastfetch | Prints system information | `fastfetch` | [repo](https://github.com/fastfetch-cli/fastfetch) |
| xclip | Clipboard access on X11 | `echo hi \| xclip -selection clipboard` | [repo](https://github.com/astrand/xclip) |
| wl-clipboard | Clipboard access on Wayland | `echo hi \| wl-copy`, `wl-paste` | [repo](https://github.com/bugaevc/wl-clipboard) |

### Development

| Tool | What it does | Usage | Links |
|------|--------------|-------|-------|
| Git | Version control | `git st`, `git co`, `git br`, `git lg` | [website](https://git-scm.com) · [repo](https://github.com/git/git) |
| GitHub CLI | GitHub from the terminal | `gh pr create`, `gh run list` | [website](https://cli.github.com) · [repo](https://github.com/cli/cli) |
| lazygit | Terminal UI for git | `lazygit` | [repo](https://github.com/jesseduffield/lazygit) |
| direnv | Loads per-directory environments | `echo 'use flake' > .envrc`, then `direnv allow` | [website](https://direnv.net) · [repo](https://github.com/direnv/direnv) |
| nix-direnv | Fast, cached `use flake` for direnv | Automatic with direnv | [repo](https://github.com/nix-community/nix-direnv) |
| GCC | C and C++ compiler | `gcc main.c -o main` | [website](https://gcc.gnu.org) · [repo](https://github.com/gcc-mirror/gcc) |
| CMake | C and C++ build generator | `cmake -B build`, `cmake --build build` | [website](https://cmake.org) · [repo](https://github.com/Kitware/CMake) |
| GNU Make | Runs build targets | `make check` | [website](https://www.gnu.org/software/make/) · [repo mirror](https://github.com/mirror/make) |
| Python | Default `python` is the Nix 3.13 | `python3` | [website](https://www.python.org) · [repo](https://github.com/python/cpython) |
| uv | Python versions, virtual environments and packages | See [Python versions](#python-versions) | [website](https://docs.astral.sh/uv/) · [repo](https://github.com/astral-sh/uv) |
| rustup | Installs and switches Rust toolchains | `rustup default stable` | [website](https://rustup.rs) · [repo](https://github.com/rust-lang/rustup) |
| Node.js | JavaScript runtime | `node`, `npm install -g pkg` | [website](https://nodejs.org) · [repo](https://github.com/nodejs/node) |

### Neovim plugins

| Plugin | What it does | Usage | Links |
|--------|--------------|-------|-------|
| lazy.nvim | Plugin manager | `:Lazy` | [website](https://lazy.folke.io) · [repo](https://github.com/folke/lazy.nvim) |
| nvim-treesitter | Syntax parsing and highlighting | Automatic | [repo](https://github.com/nvim-treesitter/nvim-treesitter) |
| nvim-lspconfig | Language server setup | `gd`, `gD`, `<leader>d` | [repo](https://github.com/neovim/nvim-lspconfig) |
| blink.cmp | Completion | Automatic | [repo](https://github.com/saghen/blink.cmp) |
| conform.nvim | Formatting | On save, or `<leader>cf` | [repo](https://github.com/stevearc/conform.nvim) |
| fzf-lua | Fuzzy finding | `<leader>ff`, `fg`, `fb`, `fh`, `fr` | [repo](https://github.com/ibhagwan/fzf-lua) |
| oil.nvim | Edit directories like buffers | `-` | [repo](https://github.com/stevearc/oil.nvim) |
| gitsigns.nvim | Git changes in the sign column | Automatic | [repo](https://github.com/lewis6991/gitsigns.nvim) |
| lualine.nvim | Status line | Automatic | [repo](https://github.com/nvim-lualine/lualine.nvim) |
| which-key.nvim | Shows available keybindings | Press `<leader>` and wait | [repo](https://github.com/folke/which-key.nvim) |
| Rosé Pine | Colorscheme (moon) | Automatic | [website](https://rosepinetheme.com) · [repo](https://github.com/rose-pine/neovim) |

### Fonts

| Font | What it does | Links |
|------|--------------|-------|
| Hack Nerd Font | Terminal font with icons | [website](https://www.nerdfonts.com) · [repo](https://github.com/ryanoasis/nerd-fonts) |
| Noto | Fallback coverage, including CJK and emoji | [website](https://fonts.google.com/noto) · [repo](https://github.com/notofonts) |

## Python versions

[uv](https://docs.astral.sh/uv/) manages Python versions per project, and the default `python` stays on the Nix 3.13.

```sh
uv python install 3.11            # download a Python version
uv python list --only-installed   # show the versions uv can find

cd my-project
uv python pin 3.11                # write .python-version
uv venv                           # create .venv with that version
source .venv/bin/activate
uv run python --version           # or run through uv without activating

uv run --python 3.10 python script.py   # one-off with another version
```

`uv python install` puts its executables in `~/.local/bin`, which isn't on `PATH`, so use a virtual environment or `uv run` rather than calling `python3.11` directly.

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
nix run home-manager/release-26.05 -- switch --flake .#ideapad

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

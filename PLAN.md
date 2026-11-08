# Plan

Roadmap for the dotfiles repo, ordered by value against effort.

**Status:** sections 1–5 are done. The only open item is the `hosts/` split, which waits on a second machine.

## 1. Clean up (small)
- [x] **`terminal.nix`:** deleted the empty stub and removed it from `home.nix` and the README.
- [x] **`git.nix`:** moved to `settings.*` after upgrading the pin to `release-26.05`.
- [x] **`core.editor`:** switched to `nvim`. Removed the VS Code note from the README.
- [x] **README:** filled in the clone URL.

## 2. Neovim (the biggest gap)
The config has only a colorscheme and Treesitter. Add each of these as a separate file in `lua/plugins/`:
- [x] **Fuzzy finding:** fzf-lua (`<leader>ff/fg/fb/fh/fr`).
- [x] **LSP:** clangd, pyright, ruff, lua_ls, nil_ls from Nix; `gd`, `gD`, `<leader>d` plus Neovim's built-in `gr*`/`K`.
- [x] **Completion:** blink.cmp.
- [x] **Formatting and linting:** conform.nvim with format-on-save (stylua, ruff, nixfmt, clang-format); ruff LSP handles Python linting.
- [x] **Quality of life:** oil.nvim (`-`), gitsigns, lualine, which-key; `clipboard=unnamedplus` was already set.

## 3. Fill the stub modules
- [x] **`development.nix`:** toolchains (gcc, cmake, python3 with uv, rustup or Rust, `gh`, `direnv` with `nix-direnv`, `lazygit`).
- [x] **`environment.nix`:** `EDITOR`, `VISUAL`, `PAGER` (bat), and XDG settings.
- [x] **`desktop.nix`:** GNOME keybindings, wallpaper and lock screen settings via dconf.

## 4. Shell and terminal polish
- [x] Terminal multiplexing: using herdr instead of `tmux` or WezTerm keybinds.
- [x] Add zsh options (`cdable_vars`; history sharing was already on) and a few git aliases.
- [x] Check how `bat` and `eza` behave as `cat` and `ls` replacements in scripts and pipes. Fine in both. Fixed `PAGER` and `MANPAGER`, and removed the `grep` alias because `rg` rejects `grep` flags such as `-E`.

## 5. Repo hygiene
- [x] Added a `.gitattributes` and a GitHub Action that runs `nix build .#homeConfigurations.ideapad.activationPackage` to catch broken commits. No `nix flake check` step, because the flake defines no `checks`.
- [x] Added a `Makefile` with `switch`, `update` and `check` targets.
- [x] Removed the empty `scripts/` and `lib/` directories (`wallpapers/` is used).
- [ ] If a second machine is added, split `hosts/` into shared and per-host modules.


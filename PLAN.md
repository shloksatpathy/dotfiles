# Plan

Roadmap for the dotfiles repo, ordered by value against effort.

## 1. Clean up (small)
- [x] **`terminal.nix`:** deleted the empty stub and removed it from `home.nix` and the README.
- [x] **`git.nix`:** checked. `settings.*` doesn't exist in `release-25.05`, so `userName` and `userEmail` stay until the Home Manager pin is upgraded, then move to `settings.user.*`.
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
- [ ] **`desktop.nix`:** only add it if GUI or desktop configuration is wanted. Otherwise remove it.

## 4. Shell and terminal polish
- [ ] Add `tmux` or WezTerm multiplexing keybinds (splits, tabs, pane navigation).
- [ ] Add zsh options (`setopt` for history sharing, `cdable_vars`) and a few git aliases.
- [ ] Check how `bat` and `eza` behave as `cat` and `ls` replacements in scripts and pipes.

## 5. Repo hygiene
- [ ] Add a `.gitattributes` and a `nix flake check` step in CI. A GitHub Action that runs `nix build .#homeConfigurations.ideapad.activationPackage` would catch broken commits.
- [ ] Consider a `justfile` or `Makefile` with `switch`, `update` and `check` targets.
- [ ] Decide whether `scripts/` and `lib/` should exist (`wallpapers/` is now used). Remove them from the layout if there's no plan for them.
- [ ] If a second machine is added, split `hosts/` into shared and per-host modules.

## Suggested order
1. Section 1, as one commit.
2. Neovim: fuzzy finding, LSP and completion, so navigation and code completion work.
3. `development.nix` and `environment.nix`.
4. The rest, as needed.

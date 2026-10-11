# Plan

Roadmap for the dotfiles repo, ordered by value against effort.

## 1. Clean up (small)
- [x] **`terminal.nix`:** deleted the empty stub and removed it from `home.nix` and the README.
- [x] **`git.nix`:** checked. `settings.*` doesn't exist in `release-25.05`, so `userName` and `userEmail` stay until the Home Manager pin is upgraded, then move to `settings.user.*`.
- [x] **`core.editor`:** switched to `nvim`. Removed the VS Code note from the README.
- [x] **README:** filled in the clone URL.

## 2. Neovim (the biggest gap)
The config has only a colorscheme and Treesitter. Add each of these as a separate file in `lua/plugins/`:
- [ ] **Fuzzy finding:** telescope.nvim or fzf-lua. `ripgrep`, `fd` and `fzf` are already installed.
- [ ] **LSP:** nvim-lspconfig, plus servers for C/C++, Python, Lua and Nix (`clangd`, `pyright` or `ruff`, `lua-language-server`, `nil` or `nixd`). Install the servers through Nix rather than Mason so they stay reproducible.
- [ ] **Completion:** blink.cmp or nvim-cmp.
- [ ] **Formatting and linting:** conform.nvim, with `stylua`, `nixfmt` and `ruff` from Nix.
- [ ] **Quality of life:** a file explorer (oil.nvim), gitsigns, a statusline, which-key, and `clipboard=unnamedplus` to use the `xclip` and `wl-clipboard` packages.

## 3. Fill the stub modules
- [ ] **`development.nix`:** toolchains (gcc/clang, cmake, python3 with uv, rustup or Rust, `gh`, `direnv` with `nix-direnv`, `lazygit`).
- [ ] **`environment.nix`:** `EDITOR`, `VISUAL`, `PAGER` (bat), and XDG settings.
- [ ] **`desktop.nix`:** only add it if GUI or desktop configuration is wanted. Otherwise remove it.

## 4. Shell and terminal polish
- [ ] Add `tmux` or WezTerm multiplexing keybinds (splits, tabs, pane navigation).
- [ ] Add zsh options (`setopt` for history sharing, `cdable_vars`) and a few git aliases.
- [ ] Check how `bat` and `eza` behave as `cat` and `ls` replacements in scripts and pipes.

## 5. Repo hygiene
- [ ] Add a `.gitattributes` and a `nix flake check` step in CI. A GitHub Action that runs `nix build .#homeConfigurations.ideapad.activationPackage` would catch broken commits.
- [ ] Consider a `justfile` or `Makefile` with `switch`, `update` and `check` targets.
- [ ] Decide whether `scripts/`, `lib/` and `wallpapers/` should exist. Remove them from the layout if there's no plan for them.
- [ ] If a second machine is added, split `hosts/` into shared and per-host modules.

## Suggested order
1. Section 1, as one commit.
2. Neovim: fuzzy finding, LSP and completion, so navigation and code completion work.
3. `development.nix` and `environment.nix`.
4. The rest, as needed.

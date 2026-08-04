local map = vim.keymap.set

vim.g.mapleader = " "

map("n", "<leader>w", "<cmd>w<CR>")
map("n", "<leader>q", "<cmd>q<CR>")

map("n", "<Esc>", "<cmd>noh<CR>")

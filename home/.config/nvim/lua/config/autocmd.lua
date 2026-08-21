vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "c",
        "cpp",
        "python",
        "lua",
        "bash",
        "json",
        "nix",
        "vim",
        "vimdoc",
    },

    callback = function()
        vim.treesitter.start()
    end,
})

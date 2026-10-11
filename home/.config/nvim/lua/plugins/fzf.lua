return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "FzfLua",

        keys = {
            { "<leader>ff", "<cmd>FzfLua files<CR>",     desc = "Find files" },
            { "<leader>fg", "<cmd>FzfLua live_grep<CR>", desc = "Grep" },
            { "<leader>fb", "<cmd>FzfLua buffers<CR>",   desc = "Buffers" },
            { "<leader>fh", "<cmd>FzfLua helptags<CR>",  desc = "Help" },
            { "<leader>fr", "<cmd>FzfLua resume<CR>",    desc = "Resume last search" },
        },

        opts = {},
    },
}

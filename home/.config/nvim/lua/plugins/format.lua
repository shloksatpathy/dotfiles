return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        cmd = "ConformInfo",

        keys = {
            {
                "<leader>cf",
                function()
                    require("conform").format({ lsp_format = "fallback" })
                end,
                desc = "Format buffer",
            },
        },

        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff_format" },
                nix = { "nixfmt" },
                c = { "clang-format" },
                cpp = { "clang-format" },
            },

            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        },
    },
}

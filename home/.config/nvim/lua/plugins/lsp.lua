-- Language servers come from Nix (modules/packages.nix), not Mason.
return {
    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },

        config = function()
            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                    },
                },
            })

            vim.lsp.enable({
                "clangd",
                "pyright",
                "ruff",
                "lua_ls",
                "nil_ls",
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local function map(lhs, rhs, desc)
                        vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc })
                    end

                    map("gd", vim.lsp.buf.definition, "Go to definition")
                    map("gD", vim.lsp.buf.declaration, "Go to declaration")
                    map("<leader>d", vim.diagnostic.open_float, "Line diagnostics")
                end,
            })
        end,
    },
}

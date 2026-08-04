local M = {}

function M.setup(config)
    config.default_prog = { "/usr/bin/zsh", "-l" }

    config.initial_cols = 120
    config.initial_rows = 32
end

return M

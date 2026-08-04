local wezterm = require("wezterm")

local M = {}

function M.setup(config)
    config.font = wezterm.font_with_fallback({
        "Hack Nerd Font",
        "Noto Color Emoji",
    })

    config.font_size = 12.5
    config.line_height = 1.1
end

return M

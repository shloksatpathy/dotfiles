local wezterm = require("wezterm")

local M = {}

function M.setup(config)
    local act = wezterm.action

    config.disable_default_key_bindings = false

    config.keys = {
        {
            key = "Enter",
            mods = "ALT",
            action = act.ToggleFullScreen,
        },
    }
end

return M

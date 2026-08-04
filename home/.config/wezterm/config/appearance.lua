local M = {}

function M.setup(config)
    config.color_scheme = "rose-pine-moon"

    config.window_background_opacity = 0.8
    config.window_decorations = "NONE"

    config.hide_tab_bar_if_only_one_tab = true
    config.use_fancy_tab_bar = false
    config.tab_bar_at_bottom = false

    config.window_padding = {
        left = 10,
        right = 10,
        top = 10,
        bottom = 10,
    }

    config.window_close_confirmation = "NeverPrompt"

    config.enable_scroll_bar = false
end

return M

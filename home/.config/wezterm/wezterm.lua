local wezterm = require("wezterm")

local config = wezterm.config_builder()

require("config.appearance").setup(config)
require("config.fonts").setup(config)
require("config.keys").setup(config)
require("config.launch").setup(config)

return config

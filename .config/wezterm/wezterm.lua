-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Tokyo Night Moon"

config.mouse_bindings = {
	{
		event = { Drag = { streak = 1, button = "Left" } },
		action = wezterm.action.StartWindowDrag,
	},
}

config.font = wezterm.font("MonoLisa")

-- and finally, return the configuration to wezterm
return config

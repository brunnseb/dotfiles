-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
end)

wezterm.on("toggle-opacity", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		-- if no override is setup, override the default opacity value with 1.0
		overrides.window_background_opacity = 1.0
	else
		-- if there is an override, make it nil so the opacity goes back to the default
		overrides.window_background_opacity = nil
	end
	window:set_config_overrides(overrides)
end)

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This table will hold the configuration.
config = {
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	window_background_opacity = 0.8,
	window_close_confirmation = "NeverPrompt",
	default_prog = { "/usr/bin/fish", "-l" },
	color_scheme = "Tokyo Night Moon",
	font = wezterm.font({ family = "MonoLisa", weight = "Medium" }),
	inactive_pane_hsb = {
		saturation = 0.8,
		brightness = 0.7,
	},
	use_dead_keys = false,
	scrollback_lines = 5000,
	adjust_window_size_when_changing_font_size = false,
	window_frame = {
		font = wezterm.font({ family = "MonoLisa", weight = "Bold", italic = true }),
	},
	disable_default_key_bindings = true,
	keys = {
		{ key = "l", mods = "ALT|SHIFT", action = act.ActivateTabRelative(1) },
		{ key = "h", mods = "ALT|SHIFT", action = act.ActivateTabRelative(-1) },
		{ key = "Enter", mods = "ALT", action = act.ActivateCopyMode },
		{ key = "R", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
		{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
		{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
		{ key = "0", mods = "CTRL", action = act.ResetFontSize },
		{ key = "C", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
		{ key = "N", mods = "SHIFT|CTRL", action = act.SpawnWindow },
		{ key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
		{ key = "n", mods = "ALT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "N", mods = "ALT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "h", mods = "ALT", action = act.ActivatePaneDirection("Left") },
		{ key = "l", mods = "ALT", action = act.ActivatePaneDirection("Right") },
		{ key = "j", mods = "ALT", action = act.ActivatePaneDirection("Down") },
		{ key = "k", mods = "ALT", action = act.ActivatePaneDirection("Up") },
		{ key = "t", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "w", mods = "ALT", action = act.CloseCurrentTab({ confirm = false }) },
		{ key = "q", mods = "ALT", action = act.CloseCurrentPane({ confirm = false }) },
		{
			key = "k",
			mods = "CTRL|ALT",
			action = act.Multiple({
				act.ClearScrollback("ScrollbackAndViewport"),
				act.SendKey({ key = "L", mods = "CTRL" }),
			}),
		},
		{ key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
		{
			key = "0",
			mods = "CTRL",
			action = wezterm.action.EmitEvent("toggle-opacity"),
		},
	},
}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages

config.mouse_bindings = {
	{
		event = { Drag = { streak = 1, button = "Left" } },
		action = wezterm.action.StartWindowDrag,
	},
}

-- and finally, return the configuration to wezterm
return config

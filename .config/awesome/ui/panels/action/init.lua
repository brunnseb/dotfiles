-------------------------------------------
-- @author https://github.com/Kasper24
-- @copyright 2021-2022 Kasper24
-------------------------------------------
local awful = require("awful")
local wibox = require("wibox")
local widgets = require("ui.widgets")
local beautiful = require("beautiful")
local helpers = require("helpers")
local dpi = beautiful.xresources.apply_dpi
local capi = {
	screen = screen,
}

local instance = nil

local path = ...
local header = require(path .. ".header")
local dashboard = require(path .. ".dashboard")
local info = require(path .. ".info")

local function seperator()
	return wibox.widget({
		widget = widgets.background,
		forced_height = dpi(1),
		shape = helpers.ui.rrect(),
		bg = beautiful.colors.surface,
	})
end

local function new()
	local widget = wibox.widget({
		widget = wibox.container.margin,
		margins = dpi(25),
		{
			layout = widgets.overflow.vertical,
			spacing = dpi(25),
			scrollbar_widget = widgets.scrollbar,
			scrollbar_width = dpi(0),
			scrollbar_spacing = 0,
			step = 300,
			header,
			seperator(),
			dashboard,
			seperator(),
			info,
			seperator(),
		},
	})

	local panel = widgets.animated_panel({
		visible = false,
		ontop = true,
		minimum_width = dpi(550),
		maximum_width = dpi(550),
		max_height = true,
		placement = function(widget)
			awful.placement.top_right(widget, {
				honor_workarea = true,
				honor_padding = true,
				attach = true,
			})
		end,
		shape = helpers.ui.rrect(),
		bg = beautiful.colors.background,
		widget = widget,
	})

	return panel
end

if not instance then
	instance = new()
end
return instance

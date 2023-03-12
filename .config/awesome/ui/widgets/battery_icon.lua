-------------------------------------------
-- @author https://github.com/Kasper24
-- @copyright 2021-2022 Kasper24
-------------------------------------------
local wibox = require("wibox")
local twidget = require("ui.widgets.text")
local beautiful = require("beautiful")
local upower_daemon = require("daemons.hardware.upower")
local setmetatable = setmetatable

local battery_icon = {
	mt = {},
}

local Battery_States = {
	Low = 0,
	Medium = 1,
	High = 2,
	Full = 3,
	Charging = 4,
	Fully_charged = 5,
}

local icons = {
	[0] = beautiful.icons.battery.quarter,
	[1] = beautiful.icons.battery.half,
	[2] = beautiful.icons.battery.three_quarter,
	[3] = beautiful.icons.battery.full,
	[4] = beautiful.icons.battery.bolt,
	[5] = beautiful.icons.battery.bolt,
}

local function new()
	local widget = wibox.widget({
		widget = twidget,
		halign = "center",
		icon = beautiful.icons.battery.full,
		size = 17,
		color = beautiful.colors.white,
		text_normal_bg = beautiful.colors.white,
		text_on_normal_bg = beautiful.colors.transparent,
	})

	upower_daemon:connect_signal("battery::update", function(self, device)
		widget:set_icon(icons[device.state])
	end)

	return widget
end

function battery_icon.mt:__call(...)
	return new(...)
end

return setmetatable(battery_icon, battery_icon.mt)

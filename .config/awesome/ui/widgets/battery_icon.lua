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

local function new()
	local widget = wibox.widget({
		widget = twidget,
		halign = "center",
		icon = beautiful.icons.battery[Battery_States.Full],
		size = 17,
		color = beautiful.colors.white,
		text_normal_bg = beautiful.colors.white,
		text_on_normal_bg = beautiful.colors.transparent,
	})

	upower_daemon:connect_signal("battery::update::state", function(self, device)
		widget:set_icon(beautiful.icons.battery[device.state])
	end)

	upower_daemon:connect_signal("battery::update", function(self, device)
		if device.percentage < 15 then
			widget:set_color(beautiful.colors.red)
		end
	end)

	return widget
end

function battery_icon.mt:__call(...)
	return new(...)
end

return setmetatable(battery_icon, battery_icon.mt)

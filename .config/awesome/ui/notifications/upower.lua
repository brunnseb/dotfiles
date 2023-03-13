-------------------------------------------
-- @author https://github.com/Kasper24
-- @copyright 2021-2022 Kasper24
-------------------------------------------
local beautiful = require("beautiful")
local naughty = require("naughty")
local upower_daemon = require("daemons.hardware.upower")

local Battery_States = {
	Low = 0,
	Medium = 1,
	High = 2,
	Full = 3,
	Charging = 4,
	Fully_charged = 5,
}

local function notification(title, device)
	if device.state == Battery_States.Low then
		naughty.notification({
			app_font_icon = beautiful.icons.car_battery,
			app_icon = "battery",
			app_name = "UPower",
			font_icon = beautiful.icons.battery[device.state],
			title = title,
			text = "Running low at " .. device.percentage .. "%",
		})
	end

	if device.state == Battery_States.Medium then
		naughty.notification({
			app_font_icon = beautiful.icons.car_battery,
			app_icon = "battery",
			app_name = "UPower",
			font_icon = beautiful.icons.battery[device.state],
			title = title,
			text = "Battery is at " .. device.percentage .. "%",
		})
	end

	if device.state == Battery_States.High then
		naughty.notification({
			app_font_icon = beautiful.icons.car_battery,
			app_icon = "battery",
			app_name = "UPower",
			font_icon = beautiful.icons.battery[device.state],
			title = title,
			text = "Battery is at " .. device.percentage .. "%",
		})
	end

	if device.state == Battery_States.Full then
		naughty.notification({
			app_font_icon = beautiful.icons.car_battery,
			app_icon = "battery",
			app_name = "UPower",
			font_icon = beautiful.icons.battery[device.state],
			title = title,
			text = "Battery is at " .. device.percentage .. "%",
		})
	end
	if device.state == Battery_States.Fully_charged then
		naughty.notification({
			app_font_icon = beautiful.icons.car_battery,
			app_icon = "battery",
			app_name = "UPower",
			font_icon = beautiful.icons.battery[device.state],
			title = title,
			text = "Fully charged!",
		})
	end
	if device.state == Battery_States.Charging then
		naughty.notification({
			app_font_icon = beautiful.icons.car_battery,
			app_icon = "battery",
			app_name = "UPower",
			font_icon = beautiful.icons.battery[device.state],
			title = title,
			text = "Charging",
		})
	end
end

upower_daemon:connect_signal("battery::update::state", function(self, device)
	notification("Battery Status", device)
end)

local device_states = {}
upower_daemon:connect_signal("device::update", function(self, device)
	if device_states[device.model] == nil then
		device_states[device.model] = -1
	end
	notification(device.Model, device)
end)

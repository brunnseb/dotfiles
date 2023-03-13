-------------------------------------------
-- @author https://github.com/Kasper24
-- @copyright 2021-2022 Kasper24
-------------------------------------------
local UPower = require("lgi").require("UPowerGlib")
local gobject = require("gears.object")
local gtable = require("gears.table")
local gtimer = require("gears.timer")
local naughty = require("naughty")

local upower = {}
local instance = nil

local UPower_States = {
	Unknown = 0,
	Charging = 1,
	Discharging = 2,
	Empty = 3,
	Fully_charged = 4,
	Pending_charge = 5,
	Pending_discharge = 6,
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
	local ret = gobject({})
	gtable.crush(ret, upower, true)

	ret._private = {}
	ret._private.client = UPower.Client()
	ret._private.battery = {
		percentage = 100,
		state = Battery_States.Full,
		last_state = -1,
	}

	local get_battery = function()
		local devices = ret._private.client:get_devices()

		for _, d in ipairs(devices) do
			if d:get_object_path() == "/org/freedesktop/UPower/devices/battery_BAT0" then
				return d
			end
		end

		return nil
	end

	-- ret._private.client.on_device_added = function(client, device)
	-- 	device.on_notify = function(device)
	-- 		if device.model ~= "" and device.model ~= nil then
	-- 			ret:emit_signal("device::update", device)
	-- 			ret:emit_signal("device::update::state", device)
	-- 		end
	-- 	end
	-- end

	ret._private.device = get_battery()

	ret._private.device.on_notify = function(device)
		if device.model ~= "" and device.model ~= nil then
			ret._private.battery.percentage = device.percentage

			if device.state == UPower_States.Discharging then
				ret._private.battery.time_to_full = 0
				if device.time_to_empty ~= nil and device.time_to_empty > 0 then
					ret._private.battery.time_to_empty = device.time_to_empty
				end
			else
				ret._private.battery.time_to_empty = 0
				if device.time_to_full ~= nil and device.time_to_full > 0 then
					ret._private.battery.time_to_full = device.time_to_full
				end
			end

			if device.state == UPower_States.Discharging then
				if device.percentage > 90 then
					ret._private.battery.state = Battery_States.Full
				elseif device.percentage > 66 then
					ret._private.battery.state = Battery_States.High
				elseif device.percentage >= 33 then
					ret._private.battery.state = Battery_States.Medium
				else
					ret._private.battery.state = Battery_States.Low
				end
			elseif device.state == UPower_States.Fully_charged and device.percentage > 90 then
				ret._private.battery.state = Battery_States.Fully_charged
			elseif device.state == UPower_States.Charging and ret._private.battery_state ~= Battery_States.Charging then
				ret._private.battery.state = Battery_States.Charging
			end

			ret:emit_signal("battery::update", ret._private.battery)

			if ret._private.battery.state ~= ret._private.battery.last_state then
				ret._private.battery.last_state = ret._private.battery.state
				ret:emit_signal("battery::update::state", ret._private.battery)
			end
		end
	end

	-- gtimer.delayed_call(function()
	-- 	if ret._private.device.model ~= "" and ret._private.device.model ~= nil then
	-- 		ret:emit_signal("battery::update::state", ret._private.battery)
	-- 	end
	-- end)

	return ret
end

if not instance then
	instance = new(...)
end
return instance

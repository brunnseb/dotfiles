-------------------------------------------
-- @author https://github.com/Kasper24
-- @copyright 2021-2022 Kasper24
-------------------------------------------
local UPower = require("lgi").require("UPowerGlib")
local gobject = require("gears.object")
local gtable = require("gears.table")
local gtimer = require("gears.timer")

local upower = {}
local instance = nil

local function new()
	local ret = gobject({})
	gtable.crush(ret, upower, true)

	ret._private = {}
	ret._private.client = UPower.Client()

	ret._private.get_battery = function()
		local devices = ret._private.client:get_devices()

		for _, d in ipairs(devices) do
			if d:get_object_path() == "/org/freedesktop/UPower/devices/battery_BAT0" then
				return d
			end
		end

		return nil
	end

	ret._private.client.on_device_added = function(client, device)
		device.on_notify = function(device)
			if device.model ~= "" and device.model ~= nil then
				ret:emit_signal("device::update", device)
			end
		end
	end

	local battery = ret._private.get_battery()

	battery.on_notify = function(battery)
		if battery.model ~= "" and battery.model ~= nil then
			ret:emit_signal("battery::update", battery)
		end
	end

	gtimer.delayed_call(function()
		if battery.model ~= "" and battery.model ~= nil then
			ret:emit_signal("battery::update", battery)
		end
	end)

	return ret
end

if not instance then
	instance = new(...)
end
return instance

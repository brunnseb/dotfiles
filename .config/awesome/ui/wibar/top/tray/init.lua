-------------------------------------------
-- @author https://github.com/Kasper24
-- @copyright 2021-2022 Kasper24
-------------------------------------------
local awful = require("awful")
local ghsape = require("gears.shape")
local wibox = require("wibox")
local widgets = require("ui.widgets")
local action_panel = require("ui.panels.action")
local beautiful = require("beautiful")
-- local network_daemon = require("daemons.hardware.network")
local bluetooth_daemon = require("daemons.hardware.bluetooth")
local audio_daemon = require("daemons.hardware.audio")
local upower_daemon = require("daemons.hardware.upower")
local dpi = beautiful.xresources.apply_dpi

local tray = {
	mt = {},
}

-- local function network()
-- 	local widget = wibox.widget({
-- 		widget = widgets.text,
-- 		forced_width = dpi(30),
-- 		forced_height = dpi(25),
-- 		halign = "center",
-- 		icon = beautiful.icons.network.wifi_off,
-- 		color = beautiful.colors.white,
-- 		text_normal_bg = beautiful.colors.white,
-- 		text_on_normal_bg = beautiful.colors.transparent,
-- 		size = 17,
-- 	})
--
-- 	network_daemon:connect_signal("wireless_state", function(self, state)
-- 		if state then
-- 			widget:set_icon(beautiful.icons.router)
-- 		else
-- 			widget:set_icon(beautiful.icons.network.wifi_off)
-- 		end
-- 	end)
--
-- 	network_daemon:connect_signal("access_point::connected", function(self, ssid, strength)
-- 		if strength < 33 then
-- 			widget:set_icon(beautiful.icons.network.wifi_low)
-- 		elseif strength >= 33 then
-- 			widget:set_icon(beautiful.icons.network.wifi_medium)
-- 		elseif strength >= 66 then
-- 			widget:set_icon(beautiful.icons.network.wifi_high)
-- 		end
-- 	end)
--
-- 	return widget
-- end

local function bluetooth()
	local widget = wibox.widget({
		widget = widgets.text,
		forced_width = dpi(30),
		forced_height = dpi(30),
		halign = "center",
		icon = beautiful.icons.bluetooth.on,
		color = beautiful.colors.white,
		text_normal_bg = beautiful.colors.white,
		text_on_normal_bg = beautiful.colors.transparent,
		size = 17,
	})

	bluetooth_daemon:connect_signal("state", function(self, state)
		if state == true then
			widget:set_icon(beautiful.icons.bluetooth.on)
		else
			widget:set_icon(beautiful.icons.bluetooth.off)
		end
	end)

	return widget
end

local function volume()
	local widget = wibox.widget({
		widget = widgets.text,
		forced_width = dpi(30),
		forced_height = dpi(30),
		halign = "center",
		icon = beautiful.icons.volume.normal,
		color = beautiful.colors.white,
		text_normal_bg = beautiful.colors.white,
		text_on_normal_bg = beautiful.colors.transparent,
		size = 17,
	})

	audio_daemon:connect_signal("default_sinks_updated", function(self, device)
		if device.mute or device.volume == 0 then
			widget:set_icon(beautiful.icons.volume.off)
		elseif device.volume <= 33 then
			widget:set_icon(beautiful.icons.volume.low)
		elseif device.volume <= 66 then
			widget:set_icon(beautiful.icons.volume.normal)
		elseif device.volume > 66 then
			widget:set_icon(beautiful.icons.volume.high)
		end
	end)

	return widget
end

local function sys_tray()
	local widget = wibox.widget({
		widget = wibox.container.margin,
		margins = { top = dpi(25), bottom = dpi(25), left = dpi(5), right = dpi(5) },
		{
			widget = wibox.widget.systray,
			horizontal = false,
		},
	})

	return widget
end

local function custom_tray()
	local layout = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		forced_width = dpi(120),
		spacing = dpi(15),
		-- network(),
		bluetooth(),
		volume(),
		widgets.battery_icon(),
	})

	-- local startup = true
	-- upower_daemon:connect_signal("battery::update", function()
	-- 	if startup == true then
	-- 		layout:add(widgets.battery_icon())
	-- 		startup = false
	-- 	end
	-- end)

	local widget = wibox.widget({
		widget = wibox.container.margin,
		margins = dpi(5),
		{
			widget = widgets.button.elevated.state,
			on_normal_bg = beautiful.icons.envelope.color,
			id = "button",
			on_release = function()
				action_panel:toggle()
			end,
			layout,
		},
	})

	action_panel:connect_signal("visibility", function(self, visibility)
		if visibility == true then
			widget:get_children_by_id("button")[1]:turn_on()
		else
			widget:get_children_by_id("button")[1]:turn_off()
		end
	end)

	return widget
end

local function new()
	return wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		sys_tray(),
		custom_tray(),
	})
end

function tray.mt:__call()
	return new()
end

return setmetatable(tray, tray.mt)

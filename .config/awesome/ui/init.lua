local awful = require("awful")
local widgets = require("ui.widgets")
local helpers = require("helpers")
require(... .. ".popups.keyboard_layout")
require(... .. ".notifications")
require(... .. ".wibar")

local action_panel = require(... .. ".panels.action")
local notification_panel = require(... .. ".panels.notification")
local power_popup = require(... .. ".popups.power")
-- local lock_popup = require(... .. ".popups.lock")
local cpu_popup = require(... .. ".panels.action.info.cpu")
local ram_popup = require(... .. ".panels.action.info.ram")
local disk_popup = require(... .. ".panels.action.info.disk")
local audio_popup = require(... .. ".panels.action.info.audio")
local wifi_popup = require(... .. ".panels.action.dashboard.wifi")
local bluetooth_popup = require(... .. ".panels.action.dashboard.bluetooth")

local capi = {
	screen = screen,
	client = client,
}

capi.client.connect_signal("property::fullscreen", function(c)
	if c.fullscreen then
		action_panel:hide()
		notification_panel:hide()
		cpu_popup:hide()
		ram_popup:hide()
		disk_popup:hide()
		audio_popup:hide()
		wifi_popup:hide()
		bluetooth_popup:hide()
	end
end)

capi.client.connect_signal("focus", function(c)
	if c.fullscreen then
		action_panel:hide()
		notification_panel:hide()
		cpu_popup:hide()
		ram_popup:hide()
		disk_popup:hide()
		audio_popup:hide()
		wifi_popup:hide()
		bluetooth_popup:hide()
	end
end)

action_panel:connect_signal("visibility", function(self, visible)
	if visible == true then
		power_popup:hide()
		notification_panel:hide()
	else
		cpu_popup:hide()
		ram_popup:hide()
		disk_popup:hide()
		audio_popup:hide()
		wifi_popup:hide()
		bluetooth_popup:hide()
	end
end)

notification_panel:connect_signal("visibility", function(self, visible)
	if visible == true then
		action_panel:hide()
		power_popup:hide()
	end
end)

power_popup:connect_signal("visibility", function(self, visible)
	if visible == true then
		action_panel:hide()
		-- info_panel:hide()
		notification_panel:hide()
	end
end)

cpu_popup:connect_signal("visibility", function(self, visible)
	if visible == true then
		ram_popup:hide()
		disk_popup:hide()
		audio_popup:hide()
		wifi_popup:hide()
		bluetooth_popup:hide()
	end
end)

ram_popup:connect_signal("visibility", function(self, visible)
	if visible == true then
		cpu_popup:hide()
		disk_popup:hide()
		audio_popup:hide()
		wifi_popup:hide()
		bluetooth_popup:hide()
	end
end)

disk_popup:connect_signal("visibility", function(self, visible)
	if visible == true then
		cpu_popup:hide()
		ram_popup:hide()
		audio_popup:hide()
		wifi_popup:hide()
		bluetooth_popup:hide()
	end
end)

audio_popup:connect_signal("visibility", function(self, visible)
	if visible == true then
		cpu_popup:hide()
		ram_popup:hide()
		disk_popup:hide()
		wifi_popup:hide()
		bluetooth_popup:hide()
	end
end)

wifi_popup:connect_signal("visibility", function(self, visible)
	if visible == true then
		cpu_popup:hide()
		ram_popup:hide()
		audio_popup:hide()
		disk_popup:hide()
		bluetooth_popup:hide()
	end
end)

bluetooth_popup:connect_signal("visibility", function(self, visible)
	if visible == true then
		cpu_popup:hide()
		ram_popup:hide()
		audio_popup:hide()
		disk_popup:hide()
		wifi_popup:hide()
	end
end)

awful.screen.connect_for_each_screen(function(s)
	s.screen_mask = widgets.screen_mask(s)
end)

power_popup:connect_signal("visibility", function(visibility)
	for s in capi.screen do
		if visibility and s ~= awful.screen.focused() then
			s.screen_mask.visible = true
		end
		if visibility == false then
			s.screen_mask.visible = false
		end
	end
end)

-- lock_popup:connect_signal("visibility", function(visibility)
-- 	for s in capi.screen do
-- 		if visibility and s ~= awful.screen.focused() then
-- 			s.screen_mask.visible = true
-- 		end
-- 		if visibility == false then
-- 			s.screen_mask.visible = false
-- 		end
-- 	end
-- end)

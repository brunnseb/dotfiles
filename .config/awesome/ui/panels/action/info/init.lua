-------------------------------------------
-- @author https://github.com/Kasper24
-- @copyright 2021-2022 Kasper24
-------------------------------------------
local wibox = require("wibox")
local widgets = require("ui.widgets")
local cpu_popup = require("ui.panels.action.info.cpu")
local ram_popup = require("ui.panels.action.info.ram")
local disk_popup = require("ui.panels.action.info.disk")
local audio_popup = require("ui.panels.action.info.audio")
local beautiful = require("beautiful")
local cpu_daemon = require("daemons.hardware.cpu")
local ram_daemon = require("daemons.hardware.ram")
local disk_daemon = require("daemons.hardware.disk")
local temperature_daemon = require("daemons.hardware.temperature")
local upower_daemon = require("daemons.hardware.upower")
local audio_daemon = require("daemons.hardware.audio")
local brightness_daemon = require("daemons.system.brightness")
local helpers = require("helpers")
local dpi = beautiful.xresources.apply_dpi
local setmetatable = setmetatable
local tonumber = tonumber

local info = {
	mt = {},
}

local function progress_bar(icon, on_release, value)
	local progress_bar = wibox.widget({
		widget = widgets.progressbar,
		forced_width = dpi(390),
		forced_height = dpi(10),
		shape = helpers.ui.rrect(),
		max_value = 100,
		bar_shape = helpers.ui.rrect(),
		background_color = beautiful.colors.surface,
		color = icon.color,
	})

	local icon = wibox.widget({
		widget = widgets.background,
		shape = helpers.ui.rrect(),
		bg = beautiful.colors.surface,
		{
			widget = widgets.text,
			id = "icon",
			forced_width = dpi(40),
			forced_height = dpi(40),
			halign = "center",
			size = 15,
			icon = icon,
		},
	})

	local widget = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(15),
		icon,
		{
			widget = wibox.container.place,
			valign = "center",
			progress_bar,
		},
	})

	local val = wibox.widget({
		widget = wibox.widget.textbox,
		align = "center",
		valign = "center",
		text = "",
		font = "sans 11",
		text_normal_bg = beautiful.colors.on_background,
	})

	widget:add(val)

	if on_release ~= nil then
		local arrow = wibox.widget({
			widget = widgets.button.text.normal,
			forced_width = dpi(40),
			forced_height = dpi(40),
			size = 15,
			icon = beautiful.icons.chevron.right,
			text_normal_bg = beautiful.colors.on_background,
			on_release = function()
				on_release()
			end,
		})
		widget:add(arrow)
	end

	function widget:set_value(value)
		progress_bar.value = value
		if on_release == nil then
			val.text = value .. "%"
		end
	end

	function widget:set_icon(new_icon)
		icon:get_children_by_id("icon")[1]:set_icon(new_icon)
	end

	function widget:set_color(new_color)
		icon:get_children_by_id("icon")[1]:set_color(new_color)
		progress_bar:set_color(new_color)
	end

	return widget
end

local function cpu()
	local widget = progress_bar(beautiful.icons.cpu, function()
		cpu_popup:toggle()
	end)

	cpu_daemon:connect_signal("update::slim", function(self, value)
		widget:set_value(value)
	end)

	return widget
end

local function ram()
	local widget = progress_bar(beautiful.icons.memory, function()
		ram_popup:toggle()
	end)

	ram_daemon:connect_signal(
		"update",
		function(self, total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap)
			local used_ram_percentage = math.floor((used / total) * 100)
			widget:set_value(used_ram_percentage)
		end
	)

	return widget
end

local function disk()
	local widget = progress_bar(beautiful.icons.database, function()
		disk_popup:toggle()
	end)

	disk_daemon:connect_signal("partition", function(self, disk)
		if disk.mount == "/" then
			widget:set_value(tonumber(disk.perc))
		end
	end)

	return widget
end

local function temperature()
	local widget = progress_bar(beautiful.icons.thermometer.full)

	temperature_daemon:connect_signal("update", function(self, value)
		if value == nil then
			widget:set_icon(beautiful.icons.thermometer.quarter)
			widget:set_value(10)
		else
			if value == 0 then
				widget:set_icon(beautiful.icons.thermometer.quarter)
			elseif value <= 33 then
				widget:set_icon(beautiful.icons.thermometer.half)
			elseif value <= 66 then
				widget:set_icon(beautiful.icons.thermometer.three_quarter)
			elseif value > 66 then
				widget:set_icon(beautiful.icons.thermometer.full)
			end

			widget:set_value(value)
		end
	end)
end

local function battery()
	local progress_bar = progress_bar(beautiful.icons.battery[3])

	local remaining_time = wibox.widget({
		widget = wibox.widget.textbox,
		align = "center",
		valign = "center",
		font = "sans 13",
	})

	local widget = wibox.widget({
		layout = wibox.layout.fixed.vertical,
		forced_height = dpi(120),
		progress_bar,
		remaining_time,
	})

	local function get_time_string(time)
		local hours = nil
		local minutes = nil
		local time_string = ""
		if time > 3600 then
			hours = math.floor(time / 3600)
		end
		minutes = math.floor((time - (hours * 3600)) / 60)

		if hours ~= nil then
			time_string = hours .. " Hours "
		end

		return time_string .. minutes .. " Minutes"
	end

	upower_daemon:connect_signal("battery::update", function(self, device)
		if device.time_to_empty ~= nil and device.time_to_empty > 0 then
			remaining_time:set_text("Remaining time: " .. get_time_string(device.time_to_empty))
		elseif device.time_to_full ~= nil and device.time_to_full > 0 then
			remaining_time:set_text("Time until full: " .. get_time_string(device.time_to_full))
		else
			remaining_time:set_text("")
		end

		if device.percentage == nil then
			progress_bar:set_value(10)
		else
			if device.percentage < 15 then
				progress_bar:set_color(beautiful.colors.red)
			end

			progress_bar:set_value(math.floor(device.percentage))
		end
	end)

	upower_daemon:connect_signal("battery::update::state", function(self, value)
		if value.percentage == nil then
			progress_bar:set_icon(beautiful.icons.battery[0])
		else
			progress_bar:set_icon(beautiful.icons.battery[value.state])
		end
	end)

	return widget
end

local function brightness()
	local slider = widgets.slider({
		forced_width = dpi(390),
		maximum = 100,
		bar_active_color = beautiful.icons.volume.off.color,
	})

	local icon = wibox.widget({
		widget = widgets.background,
		shape = helpers.ui.rrect(),
		bg = beautiful.colors.surface,
		{
			widget = widgets.text,
			id = "icon",
			forced_width = dpi(40),
			forced_height = dpi(40),
			halign = "center",
			size = 15,
			icon = beautiful.icons.brightness,
		},
	})
	local widget = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(15),
		icon,
		slider,
	})

	slider:connect_signal("property::value", function(self, value)
		if value ~= nil then
			brightness_daemon:set_brightness(value)
		end
	end)

	brightness_daemon:connect_signal("update", function(self, value)
		if value >= 0 then
			slider:set_value(value)
		end
	end)

	return widget
end

local function audio()
	local slider = widgets.slider({
		forced_width = dpi(390),
		maximum = 100,
		bar_active_color = beautiful.icons.volume.off.color,
	})

	local icon = wibox.widget({
		widget = widgets.background,
		shape = helpers.ui.rrect(),
		bg = beautiful.colors.surface,
		{
			widget = widgets.text,
			id = "icon",
			forced_width = dpi(40),
			forced_height = dpi(40),
			halign = "center",
			size = 15,
			icon = beautiful.icons.volume.off,
		},
	})

	local arrow = wibox.widget({
		widget = widgets.button.text.normal,
		forced_width = dpi(40),
		forced_height = dpi(40),
		size = 15,
		icon = beautiful.icons.chevron.right,
		text_normal_bg = beautiful.colors.on_background,
		on_release = function()
			audio_popup:toggle()
		end,
	})

	local widget = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(15),
		icon,
		slider,
		arrow,
	})

	slider:connect_signal("property::value", function(self, value)
		audio_daemon:sink_set_volume(0, value)
	end)

	local icon = icon:get_children_by_id("icon")[1]
	audio_daemon:connect_signal("default_sinks_updated", function(self, device)
		slider:set_value(device.volume)

		if device.mute or device.volume == 0 then
			icon:set_icon(beautiful.icons.volume.off)
		elseif device.volume <= 33 then
			icon:set_icon(beautiful.icons.volume.low)
		elseif device.volume <= 66 then
			icon:set_icon(beautiful.icons.volume.normal)
		elseif device.volume > 66 then
			icon:set_icon(beautiful.icons.volume.high)
		end
	end)

	return widget
end

local function new()
	return wibox.widget({
		layout = wibox.layout.flex.vertical,
		spacing = dpi(15),
		cpu(),
		ram(),
		disk(),
		audio(),
		temperature(),
		brightness(),
		battery(),
	})
end

function info.mt:__call()
	return new()
end

return setmetatable(info, info.mt)

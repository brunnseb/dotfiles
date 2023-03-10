-------------------------------------------
-- @author https://github.com/Kasper24
-- @copyright 2021-2022 Kasper24
-------------------------------------------
local wibox = require("wibox")
local widgets = require("ui.widgets")
local notification_panel = require("ui.panels.notification")
local notifications_daemon = require("daemons.system.notifications")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local notification = {
	mt = {},
}

local function new()
	local widget = wibox.widget({
		widget = wibox.container.margin,
		margins = { top = dpi(5), bottom = dpi(5), left = dpi(5), right = dpi(25) },
		{
			widget = widgets.button.text.state,
			id = "button",
			forced_width = dpi(50),
			forced_height = dpi(50),
			icon = beautiful.icons.bell,
			color = beautiful.colors.white,
			text_normal_bg = beautiful.colors.white,
			text_on_normal_bg = beautiful.colors.transparent,
			on_release = function()
				notification_panel:toggle()
			end,
		},
	})

	notifications_daemon:connect_signal("new", function()
		widget:get_children_by_id("button")[1]:set_icon(beautiful.icons.bell_ringing)
		widget:get_children_by_id("button")[1]:set_color(beautiful.colors.red)
		widget:get_children_by_id("button")[1]:set_text_normal_bg(beautiful.colors.red)
	end)

	notifications_daemon:connect_signal("empty", function()
		widget:get_children_by_id("button")[1]:set_icon(beautiful.icons.bell)
		widget:get_children_by_id("button")[1]:set_color(beautiful.colors.white)
		widget:get_children_by_id("button")[1]:set_text_normal_bg(beautiful.colors.white)
	end)

	notification_panel:connect_signal("visibility", function(self, visibility)
		if visibility == true then
			widget:get_children_by_id("button")[1]:turn_on()
		else
			widget:get_children_by_id("button")[1]:turn_off()
		end
	end)

	return widget
end

function notification.mt:__call()
	return new()
end

return setmetatable(notification, notification.mt)

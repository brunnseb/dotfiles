-------------------------------------------
-- @author https://github.com/Kasper24
-- @copyright 2021-2022 Kasper24
-------------------------------------------
local awful = require("awful")
local gobject = require("gears.object")
local gtable = require("gears.table")
local wibox = require("wibox")
local widgets = require("ui.widgets")
local beautiful = require("beautiful")
local system_daemon = require("daemons.system.system")
local helpers = require("helpers")
local dpi = beautiful.xresources.apply_dpi
local os = os

local lock = {}
local instance = nil

local accent_color = beautiful.colors.random_accent_color()

function lock:show()
	self.widget.screen = awful.screen.focused()
	self.widget.visible = true

	self._private.prompt:start()

	self:emit_signal("visibility", true)
end

function lock:hide()
	self._private.prompt:stop()

	self.widget.visible = false

	self:emit_signal("visibility", false)
end

function lock:toggle()
	if self.widget.visible then
		self:hide()
	else
		self:show()
	end
end

local function widget(self)
	local blur = wibox.widget({
		widget = widgets.background,
		bg = beautiful.colors.background_blur,
	})

	-- local picture = wibox.widget {
	--     widget = widgets.profile,
	--     halign = "center",
	--     clip_shape = helpers.ui.rrect(),
	--     forced_height = dpi(180),
	--     forced_width = dpi(180),
	-- }

	local name = wibox.widget({
		widget = widgets.text,
		halign = "center",
		color = beautiful.colors.on_background,
		text = os.getenv("USER"):upper(),
	})

	local user = wibox.widget({
		layout = wibox.layout.fixed.vertical,
		spacing = dpi(15),
		-- picture,
		name,
	})

	local clock = wibox.widget({
		widget = widgets.textclock,
		format = "%H:%M",
		size = 60,
	})

	local date = wibox.widget({
		widget = widgets.textclock,
		format = "%d" .. helpers.string.day_ordinal_number() .. " of %B, %A",
		size = 30,
	})

	self._private.prompt = wibox.widget({
		widget = widgets.prompt,
		forced_width = dpi(450),
		forced_height = dpi(50),
		reset_on_stop = true,
		always_on = true,
		obscure = true,
		icon = {
			font = beautiful.icons.lock.font,
			size = beautiful.icons.lock.size,
			icon = beautiful.icons.lock.icon,
			color = accent_color,
		},
	})

	self._private.prompt:connect_signal("key::press", function(self, mod, key, text)
		if key == "Return" then
			system_daemon:unlock(text)
		end
	end)

	local toggle_password_obscure_button = wibox.widget({
		widget = widgets.checkbox,
		state = true,
		handle_active_color = accent_color,
		on_turn_on = function()
			self._private.prompt:set_obscure(true)
		end,
		on_turn_off = function()
			self._private.prompt:set_obscure(false)
		end,
	})

	local unlock_button = wibox.widget({
		widget = widgets.button.text.normal,
		text_normal_bg = beautiful.colors.on_background,
		text = "Unlock",
		on_release = function()
			system_daemon:unlock(self._private.prompt:get_text())
		end,
	})

	local shutdown_button = wibox.widget({
		widget = widgets.button.text.normal,
		forced_width = dpi(100),
		forced_height = dpi(100),
		icon = beautiful.icons.poweroff,
		text_normal_bg = accent_color,
		size = 40,
		on_release = function()
			system_daemon:shutdown()
		end,
	})

	local restart_button = wibox.widget({
		widget = widgets.button.text.normal,
		forced_width = dpi(100),
		forced_height = dpi(100),
		icon = beautiful.icons.reboot,
		text_normal_bg = accent_color,
		size = 40,
		on_release = function()
			system_daemon:restart()
		end,
	})

	local suspend_button = wibox.widget({
		widget = widgets.button.text.normal,
		forced_width = dpi(100),
		forced_height = dpi(100),
		icon = beautiful.icons.suspend,
		text_normal_bg = accent_color,
		size = 40,
		on_release = function()
			system_daemon:suspend()
		end,
	})

	local exit_button = wibox.widget({
		widget = widgets.button.text.normal,
		forced_width = dpi(100),
		forced_height = dpi(100),
		icon = beautiful.icons.exit,
		text_normal_bg = accent_color,
		size = 40,
		on_release = function()
			system_daemon:exit()
		end,
	})

	return wibox.widget({
		widget = wibox.layout.stack,
		widgets.wallpaper,
		blur,
		{
			widget = wibox.container.place,
			halign = "center",
			valign = "center",
			{
				layout = wibox.layout.fixed.vertical,
				spacing = dpi(15),
				clock,
				date,
				user,
				{
					layout = wibox.layout.fixed.horizontal,
					spacing = dpi(15),
					self._private.prompt,
					toggle_password_obscure_button,
				},
				unlock_button,
			},
		},
		{
			widget = wibox.container.margin,
			margins = {
				bottom = dpi(30),
				right = dpi(30),
			},
			{
				widget = wibox.container.place,
				halign = "right",
				valign = "bottom",
				{
					layout = wibox.layout.fixed.horizontal,
					spacing = dpi(15),
					shutdown_button,
					restart_button,
					suspend_button,
					exit_button,
				},
			},
		},
	})
end

local function new()
	local ret = gobject({})
	gtable.crush(ret, lock, true)

	ret._private = {}
	ret._private.grabber = nil

	ret.widget = widgets.popup({
		visible = false,
		ontop = true,
		placement = awful.placement.maximize,
		widget = widget(ret),
	})

	system_daemon:connect_signal("lock", function()
		ret:show()
	end)

	system_daemon:connect_signal("unlock", function()
		ret:hide()
	end)

	system_daemon:connect_signal("wrong_password", function()
		ret._private.prompt:set_text("")
	end)

	return ret
end

if not instance then
	instance = new()
end
return instance

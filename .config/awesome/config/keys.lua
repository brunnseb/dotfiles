-------------------------------------------
-- @author https://github.com/Kasper24
-- @copyright 2021-2022 Kasper24
-------------------------------------------
local awful = require("awful")
local screenshot_widget = require("ui.apps.screenshot")
local main_menu = require("ui.popups.main_menu")
local power_popup = require("ui.popups.power")
local hotkeys_popup = require("ui.popups.hotkeys")
local layout_switcher = require("ui.popups.layout_switcher")
local theme_daemon = require("daemons.system.theme")
local screenshot_daemon = require("daemons.system.screenshot")
local helpers = require("helpers")
local bling = require("external.bling")
local machi = require("external.layout-machi")
local revelation = require("revelation")
local switcher = require("awesome-switcher")

-- TODO: Move to theme and set all correct settings
switcher.settings.preview_box_bg = "#dddddd00"

local capi = {
	awesome = awesome,
	client = client,
}
local keys = {
	mod = "Mod4",
	ctrl = "Control",
	shift = "Shift",
	alt = "Mod1",
}

-- =============================================================================
--  Awesome
-- =============================================================================
awful.keyboard.append_global_keybindings({ -- restart awesomewm
	awful.key({
		modifiers = { keys.mod, keys.shift },
		key = "r",
		group = "awesome",
		description = "reload",
		on_press = capi.awesome.restart,
	}), -- quit awesomewm
	awful.key({
		modifiers = { keys.alt },
		key = "Escape",
		group = "awesome",
		description = "quit",
		on_press = capi.awesome.quit,
	}),
})

-- =============================================================================
--  Screen
-- =============================================================================
awful.keyboard.append_global_keybindings({ -- Focus the next screen
	awful.key({
		modifiers = { keys.alt },
		key = "l",
		group = "screen",
		description = "focus the next screen",
		on_press = function(c)
			awful.screen.focus_relative(1)
		end,
	}), -- Focus the previous screen
	awful.key({
		modifiers = { keys.alt },
		key = "h",
		group = "screen",
		description = "focus the previous screen",
		on_press = function(c)
			awful.screen.focus_relative(-1)
		end,
	}),
})

-- =============================================================================
--  Client
-- =============================================================================
capi.client.connect_signal("request::default_mousebindings", function()
	awful.mouse.append_client_mousebindings({ -- Focus a client
		awful.button({
			modifiers = {},
			button = 1,
			on_press = function(c)
				c:activate({
					context = "mouse_click",
				})
			end,
		}), -- Make a client floating and move it
		awful.button({
			modifiers = { keys.mod },
			button = 1,
			on_press = function(c)
				c.floating = true
				c.maximized = false
				c:activate({
					context = "mouse_click",
					action = "mouse_move",
				})
			end,
		}), -- Make a client floating and resize it
		awful.button({
			modifiers = { keys.mod },
			button = 3,
			on_press = function(c)
				if c.can_resize ~= false then
					c.floating = true
					c.maximized = false
					c:activate({
						context = "mouse_click",
						action = "mouse_resize",
					})
				end
			end,
		}),
	})
end)

capi.client.connect_signal("request::default_keybindings", function()
	awful.keyboard.append_client_keybindings({ -- Close client
		awful.key({
			modifiers = { keys.mod, keys.shift },
			key = "q",
			group = "client",
			description = "close",
			on_press = function(c)
				c:kill()
			end,
		}), -- Toggle titlebar
		awful.key({
			modifiers = { keys.mod },
			key = "t",
			group = "client",
			description = "toggle titlebar",
			on_press = function(c)
				if c.custom_titlebar ~= true then
					if c.titlebar == nil then
						c.titlebar = true
					else
						c.titlebar = not c.titlebar
					end
					awful.titlebar.toggle(c)
				end
			end,
		}), -- Toggle floating
		awful.key({
			modifiers = { keys.mod },
			key = "space",
			group = "client",
			description = "toggle floating",
			on_press = function(c)
				if c.floating == true and c.can_tile == false then
					return
				end
				awful.client.floating.toggle()
			end,
		}), -- Toggle fullscreen
		awful.key({
			modifiers = { keys.mod },
			key = "f",
			group = "client",
			description = "toggle fullscreen",
			on_press = function(c)
				c.fullscreen = not c.fullscreen
				c:raise()
			end,
		}), -- Toggle tile layout
		awful.key({
			modifiers = { keys.mod },
			key = "s",
			group = "client",
			description = "toggle maximize client",
			on_press = function(c)
				awful.layout.set(awful.layout.suit.tile.right)
			end,
		}), -- Toggle maximize client vertically
		awful.key({
			modifiers = { keys.mod },
			key = "w",
			group = "client",
			description = "toggle maximize client",
			on_press = function(c)
				c:raise()
				awful.layout.set(awful.layout.suit.max)
			end,
		}), -- Toggle maximize client vertically
		awful.key({
			modifiers = { keys.mod, keys.ctrl },
			key = "w",
			group = "client",
			description = "toggle maximize client vertically",
			on_press = function(c)
				c.maximized_vertical = not c.maximized_vertical
				c:raise()
			end,
		}), -- Toggle maximize client horizontally
		awful.key({
			modifiers = { keys.mod, keys.shift },
			key = "w",
			group = "client",
			description = "toggle maximize client horizontally",
			on_press = function(c)
				c.maximized_horizontal = not c.maximized_horizontal
				c:raise()
			end,
		}), -- Minimize client
		awful.key({
			modifiers = { keys.mod },
			key = "n",
			group = "client",
			description = "minimize",
			on_press = function(c)
				c.minimized = true
			end,
		}), -- Restore minimized clients
		awful.key({
			modifiers = { keys.mod, keys.shift },
			key = "n",
			group = "client",
			description = "restore minimized",
			on_press = function()
				local c = awful.client.restore()
				if c then
					c:activate({
						raise = true,
						context = "key.unminimize",
					})
				end
			end,
		}), -- Make tiny float and keep on top
		awful.key({
			modifiers = { keys.mod, keys.shift },
			key = "b",
			group = "client",
			description = "make tiny float and keep on top",
			on_press = function(c)
				c.floating = not c.floating
				c.width = 400
				c.height = 200
				awful.placement.bottom_right(c)
				c.sticky = not c.sticky
			end,
		}), -- Move and resize to center
		awful.key({
			modifiers = { keys.mod, keys.shift },
			key = "c",
			group = "client",
			description = "move and resize to center",
			on_press = function(c)
				helpers.client.float_and_resize(
					c,
					awful.screen.focused().geometry.width * 0.9,
					awful.screen.focused().geometry.height * 0.9
				)
			end,
		}), -- Center a client
		awful.key({
			modifiers = { keys.mod },
			key = "c",
			group = "client",
			description = "move to center",
			on_press = function(c)
				awful.placement.centered(c, {
					honor_workarea = true,
					honor_padding = true,
				})
			end,
		}), -- Move up
		awful.key({
			modifiers = { keys.mod, keys.shift },
			key = "k",
			group = "client",
			description = "move up",
			on_press = function(c)
				helpers.client.move(c, "up")
			end,
		}), -- Move down
		awful.key({
			modifiers = { keys.mod, keys.shift },
			key = "j",
			group = "client",
			description = "move down",
			on_press = function(c)
				helpers.client.move(c, "down")
			end,
		}), -- Move left
		awful.key({
			modifiers = { keys.mod, keys.shift },
			key = "h",
			group = "client",
			description = "move left",
			on_press = function(c)
				helpers.client.move(c, "left")
			end,
		}), -- Move right
		awful.key({
			modifiers = { keys.mod, keys.shift },
			key = "l",
			group = "client",
			description = "move right",
			on_press = function(c)
				helpers.client.move(c, "right")
			end,
		}), -- Resize up
		awful.key({
			modifiers = { keys.mod, keys.ctrl },
			key = "k",
			group = "client",
			description = "resize up",
			on_press = function(c)
				if c.can_resize ~= false then
					helpers.client.resize(c, "up")
				end
			end,
		}), -- Resize down
		awful.key({
			modifiers = { keys.mod, keys.ctrl },
			key = "j",
			group = "client",
			description = "resize down",
			on_press = function(c)
				if c.can_resize ~= false then
					helpers.client.resize(c, "down")
				end
			end,
		}), -- Resize left
		awful.key({
			modifiers = { keys.mod, keys.ctrl },
			key = "h",
			group = "client",
			description = "resize left",
			on_press = function(c)
				if c.can_resize ~= false then
					helpers.client.resize(c, "left")
				end
			end,
		}), -- Resize right
		awful.key({
			modifiers = { keys.mod, keys.ctrl },
			key = "l",
			group = "client",
			description = "resize right",
			on_press = function(c)
				if c.can_resize ~= false then
					helpers.client.resize(c, "right")
				end
			end,
		}), -- Focus up
		awful.key({
			modifiers = { keys.mod },
			key = "k",
			group = "client",
			description = "focus up",
			on_press = function()
				awful.client.focus.bydirection("up")
			end,
		}), -- Focus down
		awful.key({
			modifiers = { keys.mod },
			key = "j",
			group = "client",
			description = "focus down",
			on_press = function()
				awful.client.focus.bydirection("down")
			end,
		}), -- Focus left
		awful.key({
			modifiers = { keys.mod },
			key = "h",
			group = "client",
			description = "focus previous",
			on_press = function()
				local layout = awful.layout.getname()
				if layout == "max" then
					awful.client.focus.byidx(-1)
				else
					awful.client.focus.bydirection("left")
				end
			end,
		}), -- Focus right
		awful.key({
			modifiers = { keys.mod },
			key = "l",
			group = "client",
			description = "focus next",
			on_press = function()
				local layout = awful.layout.getname()
				if layout == "max" then
					awful.client.focus.byidx(1)
				else
					awful.client.focus.bydirection("right")
				end
			end,
		}),
		-- Swap focused client with master
		awful.key({
			modifiers = { keys.mod, keys.shift },
			key = "Return",
			group = "client",
			description = "swap with master",
			on_press = function(c)
				c:swap(awful.client.getmaster())
			end,
		}), -- Go back in history
		awful.key({
			modifiers = { keys.mod },
			key = "Tab",
			group = "client",
			description = "go back in history",
			on_press = function(c)
				awful.client.focus.history.previous()
				c:raise()
			end,
		}), -- Jump to urgent
		awful.key({
			modifiers = { keys.mod, keys.shift },
			key = "u",
			group = "client",
			description = "jump to urgent",
			on_press = awful.client.urgent.jumpto,
		}), -- Bling-tabbed - pick client to add to tab group
		awful.key({
			modifiers = { keys.alt },
			key = "t",
			group = "client",
			description = "pick client to add to tab group",
			on_press = function(c)
				bling.module.tabbed.pick()
			end,
		}), -- Bling-tabbed - iterate through tabbing group
		awful.key({
			modifiers = { keys.mod },
			key = "]",
			group = "client",
			description = "iterate through tabbing group",
			on_press = function(c)
				bling.module.tabbed.iter()
			end,
		}), -- Bling-tabbed - remove focused client from tabbing group
		awful.key({
			modifiers = { keys.mod },
			key = "[",
			group = "client",
			description = "remove focused client from tabbing group",
			on_press = function(c)
				bling.module.tabbed.pop()
			end,
		}),
	})
end)

-- =============================================================================
--  Layout
-- =============================================================================
awful.keyboard.append_global_keybindings({ -- Add padding
	awful.key({
		modifiers = { keys.mod, keys.shift },
		key = "=",
		group = "layout",
		description = "increase padding",
		on_press = function()
			local current_client_gap = theme_daemon:get_client_gap()
			theme_daemon:set_client_gap(current_client_gap + 5)
		end,
	}), -- Subtract padding
	awful.key({
		modifiers = { keys.mod, keys.shift },
		key = "-",
		group = "layout",
		description = "decrease padding",
		on_press = function()
			local current_client_gap = theme_daemon:get_client_gap()
			theme_daemon:set_client_gap(current_client_gap - 5)
		end,
	}), -- Add gaps
	awful.key({
		modifiers = { keys.mod },
		key = "=",
		group = "layout",
		description = "increase gaps",
		on_press = function()
			local current_useless_gap = theme_daemon:get_useless_gap()
			theme_daemon:set_useless_gap(current_useless_gap + 5)
		end,
	}), -- Subtract gaps
	awful.key({
		modifiers = { keys.mod },
		key = "-",
		group = "layout",
		description = "decrease gaps",
		on_press = function()
			local current_useless_gap = theme_daemon:get_useless_gap()
			theme_daemon:set_useless_gap(current_useless_gap - 5)
		end,
	}), -- Increase master width
	awful.key({
		modifiers = { keys.mod },
		key = "Left",
		group = "layout",
		description = "increase master width",
		on_press = function()
			awful.tag.incmwfact(0.05)
		end,
	}), -- Decrease master width
	awful.key({
		modifiers = { keys.mod },
		key = "Right",
		group = "layout",
		description = "decrease master width",
		on_press = function()
			awful.tag.incmwfact(-0.05)
		end,
	}), -- Increase number of master clients
	awful.key({
		modifiers = { keys.mod, keys.shift },
		key = "h",
		group = "layout",
		description = "increase number of master clients",
		on_press = function()
			awful.tag.incnmaster(1, nil, true)
		end,
	}), -- Decrase number of master clients
	awful.key({
		modifiers = { keys.mod, keys.shift },
		key = "l",
		group = "layout",
		description = "decrease number of master clients",
		on_press = function()
			awful.tag.incnmaster(-1, nil, true)
		end,
	}), -- Increase number of columns
	awful.key({
		modifiers = { keys.mod, keys.ctrl },
		key = "h",
		group = "layout",
		description = "increase number of columns",
		on_press = function()
			awful.tag.incncol(1, nil, true)
		end,
	}), -- Decrease number of columns
	awful.key({
		modifiers = { keys.mod, keys.ctrl },
		key = "l",
		group = "layout",
		description = "decrease number of columns",
		on_press = function()
			awful.tag.incncol(-1, nil, true)
		end,
	}), -- layout-machi - Edit the current layout if it is a machi layout
	awful.key({
		modifiers = { keys.mod },
		key = ".",
		group = "layout",
		description = "edit the current layout if it is a machi layout",
		on_press = function()
			machi.default_editor.start_interactive()
		end,
	}), -- layout-machi - Switch between windows for a machi layout
	awful.key({
		modifiers = { keys.mod },
		key = "/",
		group = "layout",
		description = "switch between windows for a machi layout",
		on_press = function()
			machi.switcher.start(capi.client.focus)
		end,
	}),
})

-- =============================================================================
--  Tag
-- =============================================================================
awful.keyboard.append_global_keybindings({ -- View desktop
	awful.key({
		modifiers = { keys.alt },
		key = "k",
		description = "view next tag",
		group = "tag",
		on_press = function()
			awful.tag.viewprev()
		end,
	}), -- Focus left
	awful.key({
		modifiers = { keys.alt },
		key = "j",
		description = "view previous tag",
		group = "tag",
		on_press = function()
			awful.tag.viewnext()
		end,
	}), -- Focus left
	awful.key({
		modifiers = { keys.mod },
		key = "a",
		group = "tag",
		description = "revelation",
		on_press = function()
			revelation()
		end,
	}),
	awful.key({
		modifiers = { keys.mod },
		key = "x",
		group = "tag",
		description = "view none",
		on_press = function()
			awful.tag.viewnone()
		end,
	}), -- View a tag
	awful.key({
		modifiers = { keys.mod },
		keygroup = "numrow",
		description = "view tag",
		group = "tag",
		on_press = function(index)
			-- needed for the last tag
			if index == 0 then
				index = 10
			end
			helpers.misc.tag_back_and_forth(index)
		end,
	}), -- Toggle tag
	awful.key({
		modifiers = { keys.mod, keys.alt },
		keygroup = "numrow",
		description = "toggle tag",
		group = "tag",
		on_press = function(index)
			-- needed for the last tag
			if index == 0 then
				index = 10
			end
			local tag = awful.screen.focused().tags[index]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end,
	}), -- Move focused client to tag
	awful.key({
		modifiers = { keys.mod, keys.shift },
		keygroup = "numrow",
		description = "move focused client to tag",
		group = "tag",
		on_press = function(index)
			-- needed for the last tag
			if index == 0 then
				index = 10
			end
			local focused_client = capi.client.focus
			if focused_client then
				local tag = awful.screen.focused().tags[index]
				if tag then
					focused_client:move_to_tag(tag)
				end
			end
		end,
	}), -- Move focused client and switch to tag
	awful.key({
		modifiers = { keys.mod, keys.ctrl },
		keygroup = "numrow",
		description = "move focused client and switch to tag",
		group = "tag",
		on_press = function(index)
			-- needed for the last tag
			if index == 0 then
				index = 10
			end
			local focused_client = capi.client.focus
			if focused_client then
				local tag = awful.screen.focused().tags[index]
				if tag then
					focused_client:move_to_tag(tag)
					tag:view_only()
				end
			end
		end,
	}),
})

-- =============================================================================
--  Media
-- =============================================================================
awful.keyboard.append_global_keybindings({ -- Toogle media
	awful.key({
		modifiers = {},
		key = "XF86AudioRaiseVolume",
		group = "media",
		description = "increase volume",
		on_press = function()
			awful.spawn.with_shell("volumectl up")
		end,
	}), -- Lower volume
	awful.key({
		modifiers = {},
		key = "XF86AudioLowerVolume",
		group = "media",
		description = "decrease volume",
		on_press = function()
			awful.spawn.with_shell("volumectl down")
		end,
	}), -- Mute volume
	awful.key({
		modifiers = {},
		key = "XF86AudioMute",
		group = "media",
		description = "mute volume",
		on_press = function()
			awful.spawn.with_shell("volumectl toggle-mute")
		end,
	}), -- Increase brightness
	awful.key({
		modifiers = {},
		key = "XF86MonBrightnessUp",
		group = "media",
		description = "increase brightness",
		on_press = function()
			awful.spawn.with_shell("lightctl up")
		end,
	}), -- Decrease brightness
	awful.key({
		modifiers = {},
		key = "XF86MonBrightnessDown",
		group = "media",
		description = "decrease brightness",
		on_press = function()
			awful.spawn.with_shell("lightctl down")
		end,
	}), -- Toggle Screenshot widget
	awful.key({
		modifiers = {},
		key = "Print",
		group = "media",
		description = "toggle screenshot widget",
		on_press = function()
			screenshot_widget:show()
		end,
	}), -- Take a screenshot
	awful.key({
		modifiers = { keys.mod },
		key = "Print",
		group = "media",
		description = "take a screenshot",
		on_press = function()
			screenshot_daemon:screenshot()
		end,
	}),
	-- Pick a coilor
	awful.key({
		modifiers = { keys.alt },
		key = "Print",
		group = "media",
		description = "color picker",
		on_press = function()
			screenshot_daemon:pick_color()
		end,
	}),
})

-- =============================================================================
--  UI
-- =============================================================================
awful.mouse.append_global_mousebindings({
	awful.button({ "Any" }, 1, function()
		capi.awesome.emit_signal("root::pressed", 1)
	end),
	awful.button({ "Any" }, 3, function()
		main_menu:toggle()
		capi.awesome.emit_signal("root::pressed", 3)
	end),
})

awful.keyboard.append_global_keybindings({ -- Toggle app launcher
	-- Toggle exit screen
	awful.key({
		modifiers = { keys.mod },
		key = "Escape",
		group = "ui",
		description = "toggle exit screen",
		on_press = function()
			power_popup:show()
		end,
	}), -- Toggle hotkeys
	awful.key({
		modifiers = { keys.mod },
		key = "F1",
		group = "ui",
		description = "toggle hotkeys",
		on_press = hotkeys_popup.show_help,
	}),

	awful.key({
		modifiers = { keys.alt },
		key = "Tab",
		on_press = function()
			switcher.switch(1, "Mod1", "Alt_L", "Shift", "Tab")
		end,
	}),
	awful.key({
		modifiers = { keys.alt },
		key = "Left",
		on_press = function()
			switcher.switch(-1, "Mod1", "Alt_L", "Shift", "Tab")
		end,
	}),
})

awful.keygrabber({
	keybindings = {
		awful.key({
			modifiers = { keys.mod },
			key = "e",
			on_press = function()
				layout_switcher:cycle_layouts(true)
			end,
		}),
	},
	root_keybindings = {
		awful.key({
			modifiers = { keys.mod },
			key = "e",
			on_press = function() end,
		}),
	},
	stop_key = keys.mod,
	stop_event = "release",
	start_callback = function()
		layout_switcher:show()
	end,
	stop_callback = function()
		layout_switcher:hide()
	end,
})

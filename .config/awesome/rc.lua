-------------------------------------------
-- @author https://github.com/Kasper24
-- @copyright 2021-2022 Kasper24
-------------------------------------------

pcall(require, "luarocks.loader")

local gtimer = require("gears.timer")
local collectgarbage = collectgarbage

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
gtimer({
	timeout = 5,
	autostart = true,
	call_now = true,
	callback = function()
		collectgarbage("collect")
	end,
})

local beautiful = require("beautiful")
local theme_daemon = require("daemons.system.theme")
local filesystem = require("external.filesystem")

beautiful.xresources.set_dpi(theme_daemon:get_dpi())
beautiful.init(filesystem.filesystem.get_awesome_config_dir("ui") .. "theme.lua")
local revelation = require("revelation")
revelation.init()
local nice = require("nice")
nice()

require("config")
require("ui")

-- if DEBUG ~= true then
-- 	require("daemons.system.persistent"):enable()
-- end

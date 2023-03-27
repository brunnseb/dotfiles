-------------------------------------------
-- @author https://github.com/Kasper24
-- @copyright 2021-2022 Kasper24
-------------------------------------------
local lgi = require("lgi")
local Gio = lgi.Gio
local DesktopAppInfo = Gio.DesktopAppInfo
local AppInfo = Gio.AppInfo
local awful = require("awful")
local gobject = require("gears.object")
local gtable = require("gears.table")
local beautiful = require("beautiful")
local helpers = require("helpers")
local filesystem = require("external.filesystem")
local floor = math.floor
local string = string
local table = table
local ipairs = ipairs
local math = math
local capi = {
	awesome = awesome,
	root = root,
	client = client,
	screen = screen,
	tag = tag,
}

local RUN_AS_ROOT_SCRIPT_PATH = filesystem.filesystem.get_awesome_config_dir("scripts") .. "run-as-root.sh"

local tasklist = {}
local instance = nil

local function update_positions(self)
	for _, screen in ipairs(self._private.screen) do
		local pos = 0
		local pos_without_pinned_apps = 0
		for _, pinned_app in ipairs(screen.pinned_apps_with_userdata) do
			if #helpers.client.find({ class = pinned_app.class }) == 0 then
				self:emit_signal("pinned_app::pos", pinned_app, pos)
				pos = pos + 1
			else
				self:emit_signal("pinned_app::removed", pinned_app)
			end
		end
		for _, client in ipairs(screen.all_clients) do
			if client.managed then
				self:emit_signal("client::pos", client, pos, pos_without_pinned_apps)
				pos_without_pinned_apps = pos_without_pinned_apps + 1
				pos = pos + 1
			end
		end
	end
end

local function sort_clients(self)
	self._private.screen = capi.screen

	for _, screen in ipairs(self._private.screen) do
		-- screen.pinned_apps = helpers.settings["pinned-apps"]
		screen.pinned_apps = {}
		screen.pinned_apps_with_userdata = {}

		table.sort(screen.all_clients, function(a, b)
			if a.first_tag == nil then
				return false
			elseif b.first_tag == nil then
				return true
			end

			if a.first_tag == b.first_tag or a.first_tag.selected and b.first_tag.selected then
				if a.floating ~= b.floating then
					return not a.floating
				elseif a.maximized ~= b.maximized then
					return a.maximized
				elseif a.fullscreen ~= b.fullscreen then
					return a.maximized
				else
					local a_data = self:idx(a)
					local b_data = self:idx(b)
					return a_data.col + a_data.idx < b_data.col + b_data.idx
				end
			else
				return a.first_tag.index < b.first_tag.index
			end
		end)
	end
end

local function on_pinned_app_added(self, pinned_app)
	local cloned_pinned_app = gtable.clone(pinned_app, true)
	if cloned_pinned_app.desktop_app_info_id then
		local desktop_app_info = DesktopAppInfo.new(cloned_pinned_app.desktop_app_info_id)
		cloned_pinned_app.desktop_app_info = desktop_app_info
		cloned_pinned_app.actions = self:get_actions(desktop_app_info)
	end
	cloned_pinned_app.font_icon = self:get_font_icon(pinned_app.class, pinned_app.name)

	function cloned_pinned_app:run()
		awful.spawn(cloned_pinned_app.exec)
	end

	function cloned_pinned_app:run_as_root()
		awful.spawn.with_shell(RUN_AS_ROOT_SCRIPT_PATH .. " " .. cloned_pinned_app.exec)
	end

	self:emit_signal("pinned_app::added", cloned_pinned_app)
	table.insert(self._private.screen[pinned_app.screen.index].pinned_apps_with_userdata, cloned_pinned_app)
	update_positions(self)
end

local function on_client_updated(self)
	sort_clients(self)
	update_positions(self)
end

local function on_client_added(self, client)
	local desktop_app_info, id = self:get_desktop_app_info(client)
	client.desktop_app_info = desktop_app_info
	client.desktop_app_info_id = id
	client.actions = self:get_actions(client.desktop_app_info)
	client.icon = self:get_icon(client.desktop_app_info) -- not used
	client.font_icon = self:get_font_icon(client.class, client.name)
	client.managed = true

	on_client_updated(self)
end

local function on_client_removed(self, client)
	self:emit_signal("client::removed", client)
	on_client_updated(self)
end

function tasklist:idx(client)
	client = client or capi.client.focus
	if not client then
		return
	end

	local clients = capi.screen[client.screen.index].all_clients
	local idx = nil
	for k, cl in ipairs(clients) do
		if cl == client then
			idx = k
			break
		end
	end

	local t = client.screen.selected_tag
	local nmaster = t.master_count

	-- This will happen for floating or maximized clients
	if not idx then
		return nil
	end

	if idx <= nmaster then
		return { idx = idx, col = 0, num = nmaster }
	end
	local nother = #clients - nmaster
	idx = idx - nmaster

	-- rather than regenerate the column number we can calculate it
	-- based on the how the tiling algorithm places clients we calculate
	-- the column, we could easily use the for loop in the program but we can
	-- calculate it.
	local ncol = t.column_count
	-- minimum number of clients per column
	local percol = floor(nother / ncol)
	-- number of columns with an extra client
	local overcol = math.fmod(nother, ncol)
	-- number of columns filled with [percol] clients
	local regcol = ncol - overcol

	local col = floor((idx - 1) / percol) + 1
	if col > regcol then
		-- col = floor( (idx - (percol*regcol) - 1) / (percol + 1) ) + regcol + 1
		-- simplified
		col = floor((idx + regcol + percol) / (percol + 1))
		-- calculate the index in the column
		idx = idx - percol * regcol - (col - regcol - 1) * (percol + 1)
		percol = percol + 1
	else
		idx = idx - percol * (col - 1)
	end

	return { idx = idx, col = col, num = percol }
end

function tasklist:get_desktop_app_info(client)
	local app_list = AppInfo.get_all()

	local client_props = {
		client.icon_name or false,
		client.class or false,
		client.name or false,
	}

	for _, app in ipairs(app_list) do
		if app:should_show() then
			local id = app:get_id()
			local desktop_app_info = DesktopAppInfo.new(id)
			if desktop_app_info then
				local desktop_app_props = {
					desktop_app_info:get_startup_wm_class() or false,
					id:gsub(".desktop", ""), -- file name omitting .desktop
					desktop_app_info:get_string("Name") or false, -- Declared inside the desktop file
					desktop_app_info:get_string("Icon") or false,
					desktop_app_info:get_string("Exec") or false,
				}

				for _, desktop_app_prop in ipairs(desktop_app_props) do
					for _, client_prop in ipairs(client_props) do
						if desktop_app_prop and client_prop and desktop_app_prop:lower() == client_prop:lower() then
							return desktop_app_info, id
						end
					end
				end
			end
		end
	end
end

function tasklist:get_actions(desktop_app_info)
	local actions = {}

	if desktop_app_info == nil then
		return actions
	end

	for _, action in ipairs(desktop_app_info:list_actions()) do
		table.insert(actions, {
			name = desktop_app_info:get_action_name(action),
			launch = function()
				desktop_app_info:launch_action(action)
			end,
		})
	end

	return actions
end

function tasklist:get_icon(desktop_app_info)
	if desktop_app_info then
		local icon = desktop_app_info:get_string("Icon")
		if icon ~= nil then
			return helpers.icon_theme.get_icon_path(icon)
		end
	end

	return helpers.icon_theme.choose_icon({ "window", "window-manager", "xfwm4-default", "window_list" })
end

function tasklist:get_font_icon(...)
	local args = { ... }

	for _, arg in ipairs(args) do
		if arg then
			arg = arg:lower()
			arg = arg:gsub("_", "")
			arg = arg:gsub("%s+", "")
			arg = arg:gsub("-", "")
			arg = arg:gsub("%.", "")
			local icon = beautiful.app_icons[arg]
			if icon then
				return icon
			end
		end
	end

	return beautiful.icons.window
end

function tasklist:is_app_pinned(class)
	for _, screen in ipairs(self._private.screen) do
		for _, pinned_app in ipairs(screen.pinned_apps) do
			if class == pinned_app.class then
				return true
			end
		end
	end

	return false
end

function tasklist:add_pinned_app(client)
	awful.spawn.easy_async(string.format("ps -p %d -o args=", client.pid), function(stdout)
		local pinned_app = {
			desktop_app_info_id = client.desktop_app_info_id,
			icon_name = client.icon_name,
			class = client.class,
			name = client.name,
			exec = stdout,
		}
		table.insert(self._private.screen[pinned_app.screen.index].pinned_apps, pinned_app)
		-- helpers.settings["pinned-apps"] = self._private.pinned_apps
		on_pinned_app_added(self, pinned_app)
	end)
end

function tasklist:remove_pinned_app(class)
	for _, screen in ipairs(self._private.screen) do
		for index, pinned_app in ipairs(screen.pinned_apps) do
			if pinned_app.class == class then
				self:emit_signal("pinned_app::removed", screen.pinned_apps_with_userdata[index])
				table.remove(screen.pinned_apps_with_userdata, index)
				table.remove(screen.pinned_apps, index)
				break
			end
		end
	end

	-- helpers.settings["pinned-apps"] = self._private.pinned_apps
	update_positions(self)
end

local function new()
	local ret = gobject({})
	gtable.crush(ret, tasklist, true)

	ret._private = {}
	ret._private.screen = {}

	capi.client.connect_signal("scanned", function()
		capi.client.connect_signal("request::manage", function(client)
			on_client_added(ret, client)
		end)

		for _, client in ipairs(capi.client.get()) do
			on_client_added(ret, client)
		end

		for _, screen in ipairs(ret._private.screen) do
			for _, pinned_app in ipairs(screen.pinned_apps) do
				on_pinned_app_added(ret, pinned_app)
			end
		end
	end)

	-- capi.tag.connect_signal("property::selected", function(tag)
	-- 	if tag.selected then
	-- 		on_client_updated(ret)
	-- 	end
	-- end)

	capi.client.connect_signal("request::unmanage", function(client)
		on_client_removed(ret, client)
	end)

	capi.client.connect_signal("tagged", function(client)
		if client.managed then
			on_client_updated(ret)
		end
	end)

	capi.client.connect_signal("property::floating", function(client)
		if client.managed then
			on_client_updated(ret)
		end
	end)

	capi.client.connect_signal("property::maximized", function(client)
		if client.managed then
			on_client_updated(ret)
		end
	end)

	capi.client.connect_signal("property::fullscreen", function(client)
		if client.managed then
			on_client_updated(ret)
		end
	end)

	capi.client.connect_signal("property::class", function(client)
		if client.managed then
			on_client_added(ret, client)
		end
	end)

	capi.client.connect_signal("swapped", function(client, other_client, is_source)
		if client.managed then
			on_client_updated(ret)
		end
	end)

	return ret
end

if not instance then
	instance = new()
end
return instance

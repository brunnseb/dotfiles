-------------------------------------------
-- @author https://github.com/Kasper24
-- @copyright 2021-2022 Kasper24
-------------------------------------------
local unpack = unpack or table.unpack -- luacheck: globals unpack (compatibility with Lua 5.1)
local gfilesystem = require("gears.filesystem")
local gcolor = require("gears.color")
local beautiful = require("beautiful")
local theme_daemon = require("daemons.system.theme")
local helpers = require("helpers")
local filesystem = require("external.filesystem")
local layout_machi = require("external.layout-machi")
local dpi = beautiful.xresources.apply_dpi
local pairs = pairs
local math = math

local theme = {}

local function colors()
	local colors = theme_daemon:get_active_colorscheme_colors()

	theme.colors = {
		red = colors[2],
		bright_red = colors[10],

		green = colors[3],
		bright_green = colors[11],

		yellow = colors[4],
		bright_yellow = colors[12],

		blue = colors[5],
		bright_blue = colors[13],

		magenta = colors[6],
		bright_magenta = colors[14],

		cyan = colors[7],
		bright_cyan = colors[15],

		-- background = helpers.color.add_opacity(colors[1], theme_daemon:get_ui_opacity()),
		background = helpers.color.add_opacity(colors[1], 0.8),
		background_blur = helpers.color.add_opacity(colors[1], 0.9),
		background_no_opacity = colors[1],

		-- surface = helpers.color.add_opacity(colors[9], theme_daemon:get_ui_opacity()),
		surface = helpers.color.add_opacity(colors[9], 0.8),
		surface_no_opacity = colors[9],

		error = colors[2],

		white = "#FFFFFF",
		black = "#000000",
		transparent = colors[1] .. "00",

		on_background = colors[8],
		on_background_dark = helpers.color.is_dark(colors[1]) and helpers.color.pywal_darken(colors[8], 0.4)
			or helpers.color.pywal_lighten(colors[8], 0.4),
		on_surface = colors[8],
		on_error = colors[1],
		on_accent = colors[1],
	}

	function theme.colors.random_accent_color(accent_colors)
		accent_colors = accent_colors or colors
		local accents = { unpack(accent_colors, 10, 15) }
		return accents[math.random(1, #accents)]
	end
end

local function fonts()
	-- theme.font_name = "Iosevka "
	theme.font_name = "SourceSansPro "
	theme.font = theme.font_name .. 10
	-- theme.secondary_font_name = "Oswald Medium "
	-- theme.secondary_font = theme.secondary_font_name .. 12
	-- theme.font_awesome_6_brands_font_name = "Font Awesome 6 Brands "
end

local function icons()
	theme.icons = {
		thermometer = {
			quarter = { color = theme.colors.cyan, icon = "︁", size = 30 },
			half = { color = theme.colors.cyan, icon = "", size = 30 },
			three_quarter = { color = theme.colors.cyan, icon = "︁", size = 30 },
			full = { color = theme.colors.cyan, icon = "︁", size = 30 },
		},
		network = {
			wifi_off = { color = theme.colors.cyan, icon = "" },
			wifi_low = { color = theme.colors.cyan, icon = "" },
			wifi_medium = { color = theme.colors.cyan, icon = "" },
			wifi_high = { color = theme.colors.cyan, icon = "" },
			wired_off = { color = theme.colors.cyan, icon = "" },
			wired = { color = theme.colors.cyan, icon = "" },
		},
		bluetooth = {
			on = { color = theme.colors.cyan, icon = "", font = "Nerd Font Mono " },
			off = { color = theme.colors.cyan, icon = "", font = "Nerd Font Mono " },
		},
		battery = {
			[0] = { color = theme.colors.cyan, icon = "" },
			[1] = { color = theme.colors.cyan, icon = "" },
			[2] = { color = theme.colors.cyan, icon = "" },
			[3] = { color = theme.colors.cyan, icon = "" },
			[4] = { color = theme.colors.cyan, icon = "" },
			[5] = { color = theme.colors.cyan, icon = "" },
		},
		volume = {
			off = { color = theme.colors.cyan, icon = "" },
			low = { color = theme.colors.cyan, icon = "" },
			normal = { color = theme.colors.cyan, icon = "" },
			high = { color = theme.colors.cyan, icon = "" },
		},
		bluelight = {
			on = { color = theme.colors.cyan, icon = "" },
			off = { color = theme.colors.cyan, icon = "" },
		},
		airplane = {
			on = { color = theme.colors.cyan, icon = "" },
			off = { color = theme.colors.cyan, icon = "" },
		},
		microphone = {
			on = { color = theme.colors.cyan, icon = "" },
			off = { color = theme.colors.cyan, icon = "" },
		},
		lightbulb = {
			on = { color = theme.colors.cyan, icon = "" },
			off = { color = theme.colors.cyan, icon = "" },
		},
		toggle = {
			on = { color = theme.colors.cyan, icon = "" },
			off = { color = theme.colors.cyan, icon = "" },
		},
		circle = {
			plus = { color = theme.colors.cyan, icon = "" },
			minus = { color = theme.colors.cyan, icon = "" },
		},
		caret = {
			left = { color = theme.colors.cyan, icon = "" },
			right = { color = theme.colors.cyan, icon = "" },
		},
		chevron = {
			down = { color = theme.colors.cyan, icon = "" },
			right = { color = theme.colors.cyan, icon = "" },
		},
		window = { color = theme.colors.cyan, icon = "" },
		file_manager = { color = theme.colors.cyan, icon = "" },
		terminal = { color = theme.colors.cyan, icon = "" },
		firefox = { color = theme.colors.cyan, icon = "" },
		chrome = { color = theme.colors.cyan, icon = "" },
		code = { color = theme.colors.cyan, icon = "", size = 25 },
		git = { color = theme.colors.cyan, icon = "" },
		gitkraken = { color = theme.colors.cyan, icon = "︁" },
		discord = { color = theme.colors.cyan, icon = "︁" },
		telegram = { color = theme.colors.cyan, icon = "︁" },
		spotify = { color = theme.colors.cyan, icon = "" },
		steam = { color = theme.colors.cyan, icon = "︁" },
		vscode = { color = theme.colors.cyan, icon = "﬏", size = 40 },
		github = { color = theme.colors.cyan, icon = "" },
		gitlab = { color = theme.colors.cyan, icon = "" },
		youtube = { color = theme.colors.cyan, icon = "" },
		nvidia = { color = theme.colors.cyan, icon = "︁" },
		system_monitor = { color = theme.colors.cyan, icon = "︁" },
		calculator = { color = theme.colors.cyan, icon = "" },
		vim = { color = theme.colors.cyan, icon = "" },
		neovim = { color = theme.colors.cyan, icon = "" },
		emacs = { color = theme.colors.cyan, icon = "" },

		forward = { color = theme.colors.cyan, icon = "" },
		backward = { color = theme.colors.cyan, icon = "" },
		_repeat = { color = theme.colors.cyan, icon = "" },
		shuffle = { color = theme.colors.cyan, icon = "" },

		sun = { color = theme.colors.cyan, icon = "" },
		cloud_sun = { color = theme.colors.cyan, icon = "" },
		sun_cloud = { color = theme.colors.cyan, icon = "" },
		cloud_sun_rain = { color = theme.colors.cyan, icon = "" },
		cloud_bolt_sun = { color = theme.colors.cyan, icon = "" },
		cloud = { color = theme.colors.cyan, icon = "" },
		raindrops = { color = theme.colors.cyan, icon = "" },
		snowflake = { color = theme.colors.cyan, icon = "" },
		cloud_fog = { color = theme.colors.cyan, icon = "" },
		moon = { color = theme.colors.cyan, icon = "" },
		cloud_moon = { color = theme.colors.cyan, icon = "" },
		moon_cloud = { color = theme.colors.cyan, icon = "" },
		cloud_moon_rain = { color = theme.colors.cyan, icon = "" },
		cloud_bolt_moon = { color = theme.colors.cyan, icon = "" },

		suspend = { color = theme.colors.cyan, icon = "" },
		exit = { color = theme.colors.cyan, icon = "" },

		code_pull_request = { color = theme.colors.cyan, icon = "︁" },
		commit = { color = theme.colors.cyan, icon = "" },
		star = { color = theme.colors.cyan, icon = "︁" },
		code_branch = { color = theme.colors.cyan, icon = "" },

		gamepad_alt = { color = theme.colors.cyan, icon = "" },
		lights_holiday = { color = theme.colors.cyan, icon = "" },
		download = { color = theme.colors.cyan, icon = "︁" },
		video_download = { color = theme.colors.cyan, icon = "︁" },
		speaker = { color = theme.colors.cyan, icon = "︁" },
		archeive = { color = theme.colors.cyan, icon = "︁" },
		unlock = { color = theme.colors.cyan, icon = "︁" },
		spraycan = { color = theme.colors.cyan, icon = "" },
		note = { color = theme.colors.cyan, icon = "︁" },
		image = { color = theme.colors.cyan, icon = "︁" },
		envelope = { color = theme.colors.cyan, icon = "" },
		word = { color = theme.colors.cyan, icon = "︁" },
		powerpoint = { color = theme.colors.cyan, icon = "︁" },
		excel = { color = theme.colors.cyan, icon = "︁" },
		camera_retro = { color = theme.colors.cyan, icon = "" },
		keyboard = { color = theme.colors.cyan, icon = "" },
		brightness = { color = theme.colors.cyan, icon = "" },
		circle_exclamation = { color = theme.colors.cyan, icon = "︁" },
		router = { color = theme.colors.cyan, icon = "" },
		message = { icon = "︁" },
		xmark = { color = theme.colors.cyan, icon = "" },
		microchip = { color = theme.colors.cyan, icon = "" },
		disc_drive = { color = theme.colors.cyan, icon = "" },
		gear = { color = theme.colors.cyan, icon = "" },
		check = { color = theme.colors.cyan, icon = "" },
		user = { color = theme.colors.cyan, icon = "" },
		scissors = { color = theme.colors.cyan, icon = "" },
		clock = { color = theme.colors.cyan, icon = "" },
		box = { color = theme.colors.cyan, icon = "" },
		left = { color = theme.colors.cyan, icon = "" },
		video = { color = theme.colors.cyan, icon = "" },
		industry = { color = theme.colors.cyan, icon = "" },
		calendar = { color = theme.colors.cyan, icon = "" },
		hammer = { color = theme.colors.cyan, icon = "" },
		folder_open = { color = theme.colors.cyan, icon = "" },
		launcher = { color = theme.colors.cyan, icon = "" },
		trash = { color = theme.colors.cyan, icon = "" },
		list_music = { color = theme.colors.cyan, icon = "" },
		arrow_rotate_right = { color = theme.colors.cyan, icon = "" },
		table_layout = { color = theme.colors.cyan, icon = "" },
		tag = { color = theme.colors.cyan, icon = "" },
		xmark_fw = { color = theme.colors.cyan, icon = "" },
		clouds = { color = theme.colors.cyan, icon = "" },
		circle_check = { color = theme.colors.cyan, icon = "" },
		laptop_code = { color = theme.colors.cyan, icon = "" },
		location_dot = { color = theme.colors.cyan, icon = "" },
		server = { color = theme.colors.cyan, icon = "" },
		usb = { color = theme.colors.cyan, icon = "" },
		usb_drive = { color = theme.colors.cyan, icon = "" },
		signal_stream = { color = theme.colors.cyan, icon = "" },
		car_battery = { color = theme.colors.cyan, icon = "" },
		computer = { color = theme.colors.cyan, icon = "" },
		palette = { color = theme.colors.cyan, icon = "" },
		cube = { color = theme.colors.cyan, icon = "" },
		photo_film = { color = theme.colors.cyan, icon = "" },
		clipboard = { color = theme.colors.cyan, icon = "" },
		atom = { color = theme.colors.cyan, icon = "" },
		screenshot = { color = theme.colors.cyan, icon = "" },
		notification = { color = theme.colors.cyan, icon = "" },
		poweroff = { color = theme.colors.cyan, icon = "" },
		reboot = { color = theme.colors.cyan, icon = "" },
		lock = { color = theme.colors.cyan, icon = "" },
		desktop = { color = theme.colors.cyan, icon = "" },
		logout = { color = theme.colors.cyan, icon = "" },
		plane = { color = theme.colors.cyan, icon = "" },
		cpu = { color = theme.colors.cyan, icon = "" },
		memory = { color = theme.colors.cyan, icon = "" },
		database = { color = theme.colors.cyan, icon = "" },
		square = { color = theme.colors.cyan, icon = "" },
		bell = { color = theme.colors.cyan, icon = "" },
		bell_ringing = { color = theme.colors.cyan, icon = "" },

		zero = { color = theme.colors.red, icon = "" },
		one = { color = theme.colors.red, icon = "" },
		two = { color = theme.colors.red, icon = "" },
		three = { color = theme.colors.red, icon = "" },
		four = { color = theme.colors.red, icon = "" },
		five = { color = theme.colors.red, icon = "" },
		six = { color = theme.colors.red, icon = "" },
		seven = { color = theme.colors.red, icon = "" },
		eight = { color = theme.colors.red, icon = "" },
		nine = { color = theme.colors.red, icon = "" },
	}

	theme.taglist_icons = {
		theme.icons.one,
		theme.icons.two,
		theme.icons.three,
		theme.icons.four,
		theme.icons.five,
		theme.icons.six,
		theme.icons.seven,
		theme.icons.eight,
		theme.icons.nine,
		theme.icons.zero,
	}

	theme.app_icons = {
		["atom"] = theme.icons.atom,
		["alacritty"] = theme.icons.laptop_code,
		["artemisuiexe"] = theme.icons.lights_holiday,
		["authydesktop"] = theme.icons.unlock,
		["archivemanager"] = theme.icons.archeive,
		["bitwarden"] = theme.icons.unlock,
		["blender"] = theme.icons.cube,
		["bluemanmanager"] = theme.icons.bluetooth.on,
		["btop"] = theme.icons.system_monitor,
		["bravebrowser"] = theme.icons.chrome,
		["code"] = theme.icons.vscode,
		["colorpicker"] = theme.icons.palette,
		["chromium"] = theme.icons.chrome,
		["googlechrome"] = theme.icons.chrome,
		["neovim"] = theme.icons.cube,
		["dconfeditor"] = theme.icons.computer,
		["discord"] = theme.icons.discord,
		["emacs"] = theme.icons.emacs,
		["eog"] = theme.icons.image,
		["feh"] = theme.icons.image,
		["filepicker"] = theme.icons.file_manager,
		["files"] = theme.icons.file_manager,
		["firefox"] = theme.icons.firefox,
		["firefoxdeveloperedition"] = theme.icons.firefox,
		["flameshot"] = theme.icons.camera_retro,
		["folderpicker"] = theme.icons.file_manager,
		["gimp"] = theme.icons.photo_film,
		["gitkraken"] = theme.icons.gitkraken,
		["gitqlient"] = theme.icons.git,
		["gnomecalculator"] = theme.icons.calculator,
		["gnomesystemmonitor"] = theme.icons.system_monitor,
		["gparted"] = theme.icons.disc_drive,
		["grandtheftautov"] = theme.icons.gamepad_alt,
		["gwenview"] = theme.icons.image,
		["heroic"] = theme.icons.gamepad_alt,
		["htop"] = theme.icons.system_monitor,
		["goverlay"] = theme.icons.gamepad_alt,
		["jetbrainsstudio"] = theme.icons.code,
		["keepassxc"] = theme.icons.unlock,
		["kotatogramdesktop"] = theme.icons.telegram,
		["lazygit"] = theme.icons.git,
		["libreofficewriter"] = theme.icons.word,
		["libreofficeimpress"] = theme.icons.powerpoint,
		["libreofficecalc"] = theme.icons.excel,
		["lutris"] = theme.icons.gamepad_alt,
		["lxappearance"] = theme.icons.palette,
		["mopidy"] = theme.icons.spotify,
		["mpv"] = theme.icons.video,
		["ncmpcpp"] = theme.icons.spotify,
		["nemo"] = theme.icons.file_manager,
		["networkmanagerdmenu"] = theme.icons.router,
		["teamsforlinux"] = theme.icons.message,
		["nmconnectioneditor"] = theme.icons.router,
		["notepadqq"] = theme.icons.note,
		["nvidiasettings"] = theme.icons.nvidia,
		["nvim"] = theme.icons.vim,
		["obs"] = theme.icons.video,
		["openrgb"] = theme.icons.lights_holiday,
		["parcellite"] = theme.icons.clipboard,
		["pavucontrol"] = theme.icons.speaker,
		["protontricks"] = theme.icons.gamepad_alt,
		["ranger"] = theme.icons.file_manager,
		["screenshot"] = theme.icons.camera_retro,
		["spotify"] = theme.icons.spotify,
		["steam"] = theme.icons.steam,
		["steamapp252950"] = theme.icons.gamepad_alt,
		["thunar"] = theme.icons.file_manager,
		["qbittorrent"] = theme.icons.download,
		["qemusystemx8664"] = theme.icons.computer,
		["qtcreator"] = theme.icons.code,
		["recorder"] = theme.icons.video,
		["rockstargameslauncher"] = theme.icons.gamepad_alt,
		["st"] = theme.icons.laptop_code,
		["st256color"] = theme.icons.laptop_code,
		["telegramdesktop"] = theme.icons.telegram,
		["termite"] = theme.icons.laptop_code,
		["kitty"] = theme.icons.terminal,
		["thunderbird"] = theme.icons.envelope,
		["thememanager"] = theme.icons.palette,
		["urxvt"] = theme.icons.laptop_code,
		["virtualboxmanager"] = theme.icons.computer,
		["vivaldistable"] = theme.icons.chrome,
		["vim"] = theme.icons.vim,
		["vlc"] = theme.icons.video,
		["wireshark"] = theme.icons.router,
		["wpg"] = theme.icons.spraycan,
		["webtorrent"] = theme.icons.video_download_icon,
		["welcome"] = theme.icons.computer,
		["xcolor"] = theme.icons.palette,
		["xfce4settingsmanager"] = theme.icons.computer,
	}

	local function set_icon_default_props(icon, color)
		if icon.color == nil then
			icon.color = color or theme.colors.random_accent_color()
		end
		if icon.font == nil then
			-- icon.font = "Font Awesome 6 Pro Solid "
		end
		if icon.size == nil then
			icon.size = 20
		end
	end

	for _, icon in pairs(theme.icons) do
		if icon.icon == nil then
			local color = theme.colors.random_accent_color()
			for _, _icon in pairs(icon) do
				set_icon_default_props(_icon, color)
			end
		else
			set_icon_default_props(icon)
		end
	end
end

local function assets()
	local assets_folder = filesystem.filesystem.get_awesome_config_dir("assets/images")
	theme.mountain_background = assets_folder .. "mountain.png"
	theme.overview = assets_folder .. "overview.png"

	local themes_path = gfilesystem.get_themes_dir()
	theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
	theme.layout_fairv = themes_path .. "default/layouts/fairvw.png"
	theme.layout_floating = themes_path .. "default/layouts/floatingw.png"
	theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
	theme.layout_max = themes_path .. "default/layouts/maxw.png"
	theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
	theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
	theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
	theme.layout_tile = themes_path .. "default/layouts/tilew.png"
	theme.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
	theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
	theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
	theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
	theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
	theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
	theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"
	theme.layout_machi = gcolor.recolor_image(layout_machi.get_icon(), theme.colors.on_background)
	theme.fg_normal = theme.colors.on_background -- bling uses this to recolor their layout icons
	beautiful.theme_assets.recolor_layout(theme, theme.colors.on_background)
end

local function widgets()
	theme.bg_systray = theme.colors.transparent
	theme.systray_icon_spacing = dpi(20)
	theme.systray_max_rows = 3

	theme.tabbed_spawn_in_tab = false -- whether a new client should spawn into the focused tabbing container
	theme.tabbar_ontop = true
	theme.tabbar_radius = 0 -- border radius of the tabbar
	theme.tabbar_style = "default" -- style of the tabbar ("default", "boxes" or "modern")
	theme.tabbar_font = theme.font_name .. 11 -- font of the tabbar
	theme.tabbar_size = 40 -- size of the tabbar
	theme.tabbar_position = "top" -- position of the tabbar
	theme.tabbar_bg_normal = theme.colors.background
	theme.tabbar_bg_focus = theme.colors.random_accent_color()
	theme.tabbar_fg_normal = theme.colors.on_background
	theme.tabbar_fg_focus = theme.colors.background
	theme.tabbar_disable = false

	theme.mstab_bar_ontop = false -- whether you want to allow the bar to be ontop of clients
	theme.mstab_dont_resize_slaves = false -- whether the tabbed stack windows should be smaller than the
	theme.mstab_bar_padding = dpi(0) -- how much padding there should be between clients and your tabbar
	theme.mstab_border_radius = theme.border_radius -- border radius of the tabbar
	theme.mstab_bar_height = dpi(60) -- height of the tabbar
	theme.mstab_tabbar_position = "top" -- position of the tabbar (mstab currently does not support left,right)
	theme.mstab_tabbar_style = "default" -- style of the tabbar ("default", "boxes" or "modern")

	theme.machi_editor_border_color = theme.border_color_active
	theme.machi_editor_border_opacity = 0.75
	theme.machi_editor_active_color = theme.colors.background
	theme.machi_editor_active_opacity = 0.5
	theme.machi_editor_open_color = theme.colors.background
	theme.machi_editor_open_opacity = 0.5

	theme.machi_switcher_border_color = theme.border_color_active
	theme.machi_switcher_border_opacity = 0.25
	theme.machi_switcher_fill_color = theme.colors.background
	theme.machi_switcher_fill_opacity = 0.5
	theme.machi_switcher_box_bg = theme.colors.background
	theme.machi_switcher_box_opacity = 0.85
	theme.machi_switcher_fill_color_hl = theme.colors.background
	theme.machi_switcher_fill_hl_opacity = 1
end

colors()
fonts()
icons()
assets()
widgets()

return theme

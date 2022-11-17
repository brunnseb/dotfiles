-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/brunnseb/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/brunnseb/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/brunnseb/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/brunnseb/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/brunnseb/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["agitator.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/agitator.nvim",
    url = "https://github.com/emmanueltouzery/agitator.nvim"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\nF\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\29user.plugins._bufferline\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/opt/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  carbon = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/carbon",
    url = "https://github.com/michaeldyrynda/carbon"
  },
  catppuccin = {
    after = { "bufferline.nvim" },
    config = { "\27LJ\2\n‹\17\0\1\a\1ó\1\2û\0025\1\3\0005\2\1\0009\3\0\0=\3\2\2=\2\4\0015\2\6\0009\3\5\0=\3\2\2=\2\a\0015\2\t\0009\3\b\0=\3\2\2=\2\n\0015\2\f\0009\3\v\0=\3\2\2=\2\r\0015\2\15\0009\3\14\0=\3\2\2=\2\16\0015\2\18\0009\3\17\0=\3\2\0029\3\5\0=\3\19\2=\2\20\0015\2\22\0009\3\21\0=\3\2\2=\2\23\0015\2\24\0009\3\21\0=\3\2\2=\2\25\0015\2\26\0009\3\0\0=\3\2\2=\2\27\0015\2\29\0009\3\28\0=\3\2\2=\2\30\0015\2\31\0009\3\b\0=\3\2\2=\2 \0015\2!\0009\3\14\0=\3\2\2=\2\"\0015\2#\0009\3\b\0=\3\2\2=\2$\0015\2%\0009\3\b\0=\3\2\2=\2&\0015\2'\0009\3\v\0=\3\2\2=\2(\0015\2*\0009\3)\0=\3\2\2=\2+\0015\2,\0009\3\0\0=\3\2\2=\2-\0015\2/\0009\3.\0=\3\2\2=\0020\0015\0021\0009\3\21\0=\3\2\2=\0022\0015\0024\0009\0033\0=\3\2\2=\0025\0015\0026\0009\3\17\0=\3\2\0029\0033\0=\3\19\2=\0027\0015\0028\0009\3\0\0=\3\2\2=\0029\0015\2;\0009\3:\0=\3\2\2=\2<\0015\2=\0009\3\28\0=\3\2\2=\2>\0015\2@\0009\3?\0=\3\2\2=\2A\0015\2B\0009\3\21\0=\3\2\2=\2C\0015\2D\0009\3\28\0=\3\2\2=\2E\0015\2F\0009\3:\0=\3\2\2=\2G\0015\2H\0009\3\0\0=\3\2\2=\2I\0015\2J\0009\3)\0=\3\2\2=\2K\0015\2L\0009\3\14\0=\3\2\2=\2M\0015\2N\0009\3\b\0=\3\2\2=\2O\0015\2P\0009\3\0\0=\3\2\2=\2Q\0015\2R\0009\3\21\0=\3\2\2=\2S\0015\2U\0009\3T\0=\3\2\2=\2V\0015\2W\0009\3\14\0=\3\2\2=\2X\0015\2Z\0009\3Y\0=\3\2\2=\2[\0015\2\\\0009\3T\0=\3\2\2=\2]\0015\2^\0009\0033\0=\3\2\2=\2_\0015\2a\0009\3`\0=\3\2\2=\2b\0015\2c\0009\3)\0=\3\2\2=\2d\0015\2e\0009\3\b\0=\3\2\2=\2f\0015\2g\0009\3\21\0=\3\2\2=\2h\0015\2i\0009\3\5\0=\3\2\2=\2j\0015\2k\0009\3\17\0=\3\2\0029\3\b\0=\3\19\2=\2l\0015\2m\0009\3\14\0=\3\2\2=\2n\0015\2o\0009\3\14\0=\3\2\2=\2p\0015\2q\0009\3\b\0=\3\2\0025\3r\0=\3s\2=\2t\0015\2u\0009\3\0\0=\3\2\2=\2v\0015\2w\0009\3\14\0=\3\2\2=\2x\0015\2y\0009\3\b\0=\3\2\2=\2z\0015\2{\0009\0033\0=\3\2\0025\3|\0=\3s\2=\2}\0015\2~\0009\3\21\0=\3\2\0029\3\0\0=\3\19\2=\2\127\0015\2Å\0-\3\0\0009\3Ä\0039\5\17\0*\6\0\0B\3\3\2=\3\19\2=\2Ç\0015\2É\0009\3.\0=\3\19\0029\3Ñ\0=\3\2\0025\3Ö\0=\3s\2=\2Ü\0015\2à\0009\3á\0=\3\2\2=\2â\0015\2ã\0009\3ä\0=\3\19\0029\3\21\0=\3\2\2=\2å\0015\2ç\0009\3\21\0=\3\2\0029\3\0\0=\3\19\0025\3é\0=\3s\2=\2è\0015\2ê\0-\3\0\0009\3Ä\0039\5\b\0*\6\1\0B\3\3\2=\3\19\0029\3\21\0=\3\2\0025\3ë\0=\3s\2=\2í\0015\2ì\0009\3\14\0=\3\2\2=\2î\0015\2ï\0009\3\21\0=\3\2\2-\3\0\0009\3Ä\0039\5\17\0*\6\0\0B\3\3\2=\3\19\2=\2ñ\1L\1\2\0\0¿\18NeoTreeNormal\1\0\0\14VertSplit\1\0\0\vSearch\1\2\0\0\tbold\1\0\0\rPmenuSel\1\2\0\0\tbold\1\0\0\nPmenu\1\0\0\vmantle\vLineNr\1\0\0\roverlay0\vVisual\1\2\0\0\tbold\ncrust\1\0\0\15CursorLine\1\0\0\vdarken\vCursor\1\0\0\fComment\1\2\0\0\vitalic\1\0\0\16@label.json\1\0\0\20@constructor.ts\1\0\0\23@tag.delimiter.tsx\1\0\0\23@tag.attribute.tsx\nstyle\1\2\0\0\vitalic\1\0\0\r@tag.tsx\1\0\0\21@constructor.tsx\1\0\0\r@warning\1\0\0\22@variable.builtin\1\0\0\14@variable\1\0\0\18@type.builtin\1\0\0\n@type\1\0\0\14@text.uri\1\0\0\14rosewater\16@text.title\1\0\0\17@text.strong\1\0\0\20@text.reference\1\0\0\rlavender\18@text.literal\1\0\0\19@text.emphasis\1\0\0\vmaroon\n@text\1\0\0\19@tag.delimiter\1\0\0\19@tag.attribute\1\0\0\t@tag\1\0\0\18@string.regex\1\0\0\19@string.escape\1\0\0\f@string\1\0\0\25@punctuation.special\1\0\0\25@punctuation.bracket\1\0\0\14@property\1\0\0\rflamingo\15@parameter\1\0\0\14@operator\1\0\0\ngreen\f@number\1\0\0\n@note\1\0\0\15@namespace\1\0\0\tblue\f@method\1\0\0\v@label\1\0\0\rsapphire\20@keyword.return\1\0\0\22@keyword.operator\1\0\0\npeach\22@keyword.function\1\0\0\r@keyword\1\0\0\r@include\1\0\0\20@function.macro\1\0\0\22@function.builtin\1\0\0\14@function\1\0\0\bsky\v@float\1\0\0\15@field.lua\1\0\0\v@field\1\0\0\ttext\f@danger\abg\1\0\0\tbase\17@constructor\1\0\0\tteal\20@constant.macro\1\0\0\nmauve\22@constant.builtin\1\0\0\vyellow\14@constant\1\0\0\bred\r@boolean\1\0\0\afg\1\0\0\tpinkµÊÃô\19ô≥¶ˇ\3\1ÄÄÄˇ\3\5\1\0\6\0\22\0\0306\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0015\3\4\0005\4\6\0003\5\5\0=\5\a\4=\4\b\0035\4\n\0005\5\t\0=\5\a\4=\4\v\0035\4\r\0005\5\f\0=\5\14\0045\5\15\0=\5\16\4=\4\17\3B\1\2\0016\1\18\0009\1\19\0019\1\20\1'\3\21\0B\1\2\0012\0\0ÄK\0\1\0%colorscheme catppuccin-macchiato\17nvim_command\bapi\bvim\vstyles\rbooleans\1\2\0\0\vitalic\rkeywords\1\0\0\1\2\0\0\vitalic\20color_overrides\1\0\0\1\0\26\rlavender\f#006dcc\bsky\f#90EBED\rflamingo\f#DD7878\vmaroon\f#E64553\ngreen\f#97EA88\ttext\f#E2EFFE\roverlay1\f#8C8FA1\roverlay0\f#7C7F93\roverlay2\f#9CA0B0\tteal\f#00C8A0\ncrust\f#1B2229\nmauve\f#7F6ABE\rsurface1\f#BCC0CC\vyellow\f#FFD701\rsubtext0\f#DFDFDF\bred\f#D45A7E\rsubtext1\f#5B6268\tpink\f#FF6CA4\rsurface2\f#CCD0DA\rsurface0\f#ACB0BE\tblue\f#0088FF\vmantle\f#1A3549\tbase\f#21425b\rsapphire\f#84DCC6\npeach\f#FF9D03\14rosewater\f#dc8a78\24highlight_overrides\14macchiato\1\0\0\0\1\0\1\fflavour\14macchiato\nsetup\15catppuccin\28catppuccin.utils.colors\frequire\0" },
    loaded = true,
    only_config = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/catppuccin",
    url = "https://github.com/catppuccin/nvim"
  },
  ["ccc.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/ccc.nvim",
    url = "https://github.com/uga-rosa/ccc.nvim"
  },
  ["cmp-cmdline"] = {
    after = { "cmp-fuzzy-path", "cmp-nvim-lua" },
    after_files = { "/home/brunnseb/.local/share/nvim/site/pack/packer/opt/cmp-cmdline/after/plugin/cmp_cmdline.lua" },
    load_after = {
      ["cmp-fuzzy-buffer"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/opt/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-fuzzy-buffer"] = {
    after = { "cmp-cmdline" },
    after_files = { "/home/brunnseb/.local/share/nvim/site/pack/packer/opt/cmp-fuzzy-buffer/after/plugin/cmp_fuzzy_buffer.lua" },
    load_after = {
      ["cmp-nvim-lsp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/opt/cmp-fuzzy-buffer",
    url = "https://github.com/tzachar/cmp-fuzzy-buffer"
  },
  ["cmp-fuzzy-path"] = {
    after_files = { "/home/brunnseb/.local/share/nvim/site/pack/packer/opt/cmp-fuzzy-path/after/plugin/cmp_fuzzy_path.lua" },
    load_after = {
      ["cmp-cmdline"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/opt/cmp-fuzzy-path",
    url = "https://github.com/tzachar/cmp-fuzzy-path"
  },
  ["cmp-nvim-lsp"] = {
    after = { "cmp-fuzzy-buffer" },
    after_files = { "/home/brunnseb/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    after = { "cmp_luasnip" },
    after_files = { "/home/brunnseb/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua/after/plugin/cmp_nvim_lua.lua" },
    load_after = {
      ["cmp-cmdline"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  cmp_luasnip = {
    after_files = { "/home/brunnseb/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {
      ["cmp-nvim-lua"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["document-color.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/document-color.nvim",
    url = "https://github.com/mrshmllow/document-color.nvim"
  },
  ["dressing.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["eyeliner.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/eyeliner.nvim",
    url = "https://github.com/jinh0/eyeliner.nvim"
  },
  ["filetype.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/filetype.nvim",
    url = "https://github.com/nathom/filetype.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["fuzzy.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/fuzzy.nvim",
    url = "https://github.com/tzachar/fuzzy.nvim"
  },
  ["git-conflict.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\17git-conflict\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/git-conflict.nvim",
    url = "https://github.com/akinsho/git-conflict.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\nD\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\27user.plugins._gitsigns\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["lazygit.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/lazygit.nvim",
    url = "https://github.com/kdheepak/lazygit.nvim"
  },
  ["logsitter.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/logsitter.nvim",
    url = "https://github.com/gaelph/logsitter.nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\2\nA\0\0\4\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\1\2\0004\3\0\0B\1\2\1K\0\1\0\18init_lsp_saga\flspsaga\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nC\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\26user.plugins._lualine\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/lush.nvim",
    url = "https://github.com/rktjmp/lush.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neo-tree.nvim"] = {
    config = { "\27LJ\2\nC\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\26user.plugins._neotree\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/neo-tree.nvim",
    url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
  },
  ["nnn.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\bnnn\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/nnn.nvim",
    url = "https://github.com/luukvbaal/nnn.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\nC\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\26user.plugins._null-ls\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/opt/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\rcheck_ts\2\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "cmp-nvim-lsp" },
    config = { "\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22user.plugins._cmp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\nA\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\2\0\0\6*\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\n2\0\0\4\0\3\0\0066\0\0\0006\1\2\0'\3\1\0B\1\2\2=\1\1\0K\0\1\0\frequire\vnotify\bvim\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-rooter.lua"] = {
    config = { "\27LJ\2\nG\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\30user.plugins._nvim-rooter\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/nvim-rooter.lua",
    url = "https://github.com/notjedi/nvim-rooter.lua"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nF\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\29user.plugins._treesitter\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-ufo"] = {
    config = { "\27LJ\2\nQ\0\0\4\0\5\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\2B\0\2\1K\0\1\0\21close_fold_kinds\1\0\0\nsetup\bufo\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/nvim-ufo",
    url = "https://github.com/kevinhwang91/nvim-ufo"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["nvim-window-picker"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\18window-picker\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/nvim-window-picker",
    url = "https://github.com/s1n7ax/nvim-window-picker"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["promise-async"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/promise-async",
    url = "https://github.com/kevinhwang91/promise-async"
  },
  ["schemastore.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/schemastore.nvim",
    url = "https://github.com/b0o/schemastore.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-repo.nvim"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/telescope-repo.nvim",
    url = "https://github.com/cljoly/telescope-repo.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\nE\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\28user.plugins._telescope\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["template-string.nvim"] = {
    config = { "\27LJ\2\nA\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\20template-string\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/template-string.nvim",
    url = "https://github.com/axelvc/template-string.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["typescript.nvim"] = {
    config = { "\27LJ\2\nF\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\29user.plugins._typescript\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/typescript.nvim",
    url = "https://github.com/jose-elias-alvarez/typescript.nvim"
  },
  ["vim-doge"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/vim-doge",
    url = "https://github.com/kkoomen/vim-doge"
  },
  ["vim-matchup"] = {
    after_files = { "/home/brunnseb/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/opt/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  ["vim-wordmotion"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/opt/vim-wordmotion",
    url = "https://github.com/chaoren/vim-wordmotion"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27user.plugins._whichkey\frequire\0" },
    loaded = true,
    path = "/home/brunnseb/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: typescript.nvim
time([[Config for typescript.nvim]], true)
try_loadstring("\27LJ\2\nF\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\29user.plugins._typescript\frequire\0", "config", "typescript.nvim")
time([[Config for typescript.nvim]], false)
-- Config for: nvim-window-picker
time([[Config for nvim-window-picker]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\18window-picker\frequire\0", "config", "nvim-window-picker")
time([[Config for nvim-window-picker]], false)
-- Config for: hop.nvim
time([[Config for hop.nvim]], true)
try_loadstring("\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0", "config", "hop.nvim")
time([[Config for hop.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27user.plugins._whichkey\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\nA\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\2\0\0\6*\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
try_loadstring("\27LJ\2\nA\0\0\4\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\1\2\0004\3\0\0B\1\2\1K\0\1\0\18init_lsp_saga\flspsaga\frequire\0", "config", "lspsaga.nvim")
time([[Config for lspsaga.nvim]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\2\n2\0\0\4\0\3\0\0066\0\0\0006\1\2\0'\3\1\0B\1\2\2=\1\1\0K\0\1\0\frequire\vnotify\bvim\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\nC\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\26user.plugins._lualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0", "config", "nvim-surround")
time([[Config for nvim-surround]], false)
-- Config for: nvim-ufo
time([[Config for nvim-ufo]], true)
try_loadstring("\27LJ\2\nQ\0\0\4\0\5\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\2B\0\2\1K\0\1\0\21close_fold_kinds\1\0\0\nsetup\bufo\frequire\0", "config", "nvim-ufo")
time([[Config for nvim-ufo]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\nE\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\28user.plugins._telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: catppuccin
time([[Config for catppuccin]], true)
try_loadstring("\27LJ\2\n‹\17\0\1\a\1ó\1\2û\0025\1\3\0005\2\1\0009\3\0\0=\3\2\2=\2\4\0015\2\6\0009\3\5\0=\3\2\2=\2\a\0015\2\t\0009\3\b\0=\3\2\2=\2\n\0015\2\f\0009\3\v\0=\3\2\2=\2\r\0015\2\15\0009\3\14\0=\3\2\2=\2\16\0015\2\18\0009\3\17\0=\3\2\0029\3\5\0=\3\19\2=\2\20\0015\2\22\0009\3\21\0=\3\2\2=\2\23\0015\2\24\0009\3\21\0=\3\2\2=\2\25\0015\2\26\0009\3\0\0=\3\2\2=\2\27\0015\2\29\0009\3\28\0=\3\2\2=\2\30\0015\2\31\0009\3\b\0=\3\2\2=\2 \0015\2!\0009\3\14\0=\3\2\2=\2\"\0015\2#\0009\3\b\0=\3\2\2=\2$\0015\2%\0009\3\b\0=\3\2\2=\2&\0015\2'\0009\3\v\0=\3\2\2=\2(\0015\2*\0009\3)\0=\3\2\2=\2+\0015\2,\0009\3\0\0=\3\2\2=\2-\0015\2/\0009\3.\0=\3\2\2=\0020\0015\0021\0009\3\21\0=\3\2\2=\0022\0015\0024\0009\0033\0=\3\2\2=\0025\0015\0026\0009\3\17\0=\3\2\0029\0033\0=\3\19\2=\0027\0015\0028\0009\3\0\0=\3\2\2=\0029\0015\2;\0009\3:\0=\3\2\2=\2<\0015\2=\0009\3\28\0=\3\2\2=\2>\0015\2@\0009\3?\0=\3\2\2=\2A\0015\2B\0009\3\21\0=\3\2\2=\2C\0015\2D\0009\3\28\0=\3\2\2=\2E\0015\2F\0009\3:\0=\3\2\2=\2G\0015\2H\0009\3\0\0=\3\2\2=\2I\0015\2J\0009\3)\0=\3\2\2=\2K\0015\2L\0009\3\14\0=\3\2\2=\2M\0015\2N\0009\3\b\0=\3\2\2=\2O\0015\2P\0009\3\0\0=\3\2\2=\2Q\0015\2R\0009\3\21\0=\3\2\2=\2S\0015\2U\0009\3T\0=\3\2\2=\2V\0015\2W\0009\3\14\0=\3\2\2=\2X\0015\2Z\0009\3Y\0=\3\2\2=\2[\0015\2\\\0009\3T\0=\3\2\2=\2]\0015\2^\0009\0033\0=\3\2\2=\2_\0015\2a\0009\3`\0=\3\2\2=\2b\0015\2c\0009\3)\0=\3\2\2=\2d\0015\2e\0009\3\b\0=\3\2\2=\2f\0015\2g\0009\3\21\0=\3\2\2=\2h\0015\2i\0009\3\5\0=\3\2\2=\2j\0015\2k\0009\3\17\0=\3\2\0029\3\b\0=\3\19\2=\2l\0015\2m\0009\3\14\0=\3\2\2=\2n\0015\2o\0009\3\14\0=\3\2\2=\2p\0015\2q\0009\3\b\0=\3\2\0025\3r\0=\3s\2=\2t\0015\2u\0009\3\0\0=\3\2\2=\2v\0015\2w\0009\3\14\0=\3\2\2=\2x\0015\2y\0009\3\b\0=\3\2\2=\2z\0015\2{\0009\0033\0=\3\2\0025\3|\0=\3s\2=\2}\0015\2~\0009\3\21\0=\3\2\0029\3\0\0=\3\19\2=\2\127\0015\2Å\0-\3\0\0009\3Ä\0039\5\17\0*\6\0\0B\3\3\2=\3\19\2=\2Ç\0015\2É\0009\3.\0=\3\19\0029\3Ñ\0=\3\2\0025\3Ö\0=\3s\2=\2Ü\0015\2à\0009\3á\0=\3\2\2=\2â\0015\2ã\0009\3ä\0=\3\19\0029\3\21\0=\3\2\2=\2å\0015\2ç\0009\3\21\0=\3\2\0029\3\0\0=\3\19\0025\3é\0=\3s\2=\2è\0015\2ê\0-\3\0\0009\3Ä\0039\5\b\0*\6\1\0B\3\3\2=\3\19\0029\3\21\0=\3\2\0025\3ë\0=\3s\2=\2í\0015\2ì\0009\3\14\0=\3\2\2=\2î\0015\2ï\0009\3\21\0=\3\2\2-\3\0\0009\3Ä\0039\5\17\0*\6\0\0B\3\3\2=\3\19\2=\2ñ\1L\1\2\0\0¿\18NeoTreeNormal\1\0\0\14VertSplit\1\0\0\vSearch\1\2\0\0\tbold\1\0\0\rPmenuSel\1\2\0\0\tbold\1\0\0\nPmenu\1\0\0\vmantle\vLineNr\1\0\0\roverlay0\vVisual\1\2\0\0\tbold\ncrust\1\0\0\15CursorLine\1\0\0\vdarken\vCursor\1\0\0\fComment\1\2\0\0\vitalic\1\0\0\16@label.json\1\0\0\20@constructor.ts\1\0\0\23@tag.delimiter.tsx\1\0\0\23@tag.attribute.tsx\nstyle\1\2\0\0\vitalic\1\0\0\r@tag.tsx\1\0\0\21@constructor.tsx\1\0\0\r@warning\1\0\0\22@variable.builtin\1\0\0\14@variable\1\0\0\18@type.builtin\1\0\0\n@type\1\0\0\14@text.uri\1\0\0\14rosewater\16@text.title\1\0\0\17@text.strong\1\0\0\20@text.reference\1\0\0\rlavender\18@text.literal\1\0\0\19@text.emphasis\1\0\0\vmaroon\n@text\1\0\0\19@tag.delimiter\1\0\0\19@tag.attribute\1\0\0\t@tag\1\0\0\18@string.regex\1\0\0\19@string.escape\1\0\0\f@string\1\0\0\25@punctuation.special\1\0\0\25@punctuation.bracket\1\0\0\14@property\1\0\0\rflamingo\15@parameter\1\0\0\14@operator\1\0\0\ngreen\f@number\1\0\0\n@note\1\0\0\15@namespace\1\0\0\tblue\f@method\1\0\0\v@label\1\0\0\rsapphire\20@keyword.return\1\0\0\22@keyword.operator\1\0\0\npeach\22@keyword.function\1\0\0\r@keyword\1\0\0\r@include\1\0\0\20@function.macro\1\0\0\22@function.builtin\1\0\0\14@function\1\0\0\bsky\v@float\1\0\0\15@field.lua\1\0\0\v@field\1\0\0\ttext\f@danger\abg\1\0\0\tbase\17@constructor\1\0\0\tteal\20@constant.macro\1\0\0\nmauve\22@constant.builtin\1\0\0\vyellow\14@constant\1\0\0\bred\r@boolean\1\0\0\afg\1\0\0\tpinkµÊÃô\19ô≥¶ˇ\3\1ÄÄÄˇ\3\5\1\0\6\0\22\0\0306\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0015\3\4\0005\4\6\0003\5\5\0=\5\a\4=\4\b\0035\4\n\0005\5\t\0=\5\a\4=\4\v\0035\4\r\0005\5\f\0=\5\14\0045\5\15\0=\5\16\4=\4\17\3B\1\2\0016\1\18\0009\1\19\0019\1\20\1'\3\21\0B\1\2\0012\0\0ÄK\0\1\0%colorscheme catppuccin-macchiato\17nvim_command\bapi\bvim\vstyles\rbooleans\1\2\0\0\vitalic\rkeywords\1\0\0\1\2\0\0\vitalic\20color_overrides\1\0\0\1\0\26\rlavender\f#006dcc\bsky\f#90EBED\rflamingo\f#DD7878\vmaroon\f#E64553\ngreen\f#97EA88\ttext\f#E2EFFE\roverlay1\f#8C8FA1\roverlay0\f#7C7F93\roverlay2\f#9CA0B0\tteal\f#00C8A0\ncrust\f#1B2229\nmauve\f#7F6ABE\rsurface1\f#BCC0CC\vyellow\f#FFD701\rsubtext0\f#DFDFDF\bred\f#D45A7E\rsubtext1\f#5B6268\tpink\f#FF6CA4\rsurface2\f#CCD0DA\rsurface0\f#ACB0BE\tblue\f#0088FF\vmantle\f#1A3549\tbase\f#21425b\rsapphire\f#84DCC6\npeach\f#FF9D03\14rosewater\f#dc8a78\24highlight_overrides\14macchiato\1\0\0\0\1\0\1\fflavour\14macchiato\nsetup\15catppuccin\28catppuccin.utils.colors\frequire\0", "config", "catppuccin")
time([[Config for catppuccin]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nF\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\29user.plugins._treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: template-string.nvim
time([[Config for template-string.nvim]], true)
try_loadstring("\27LJ\2\nA\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\20template-string\frequire\0", "config", "template-string.nvim")
time([[Config for template-string.nvim]], false)
-- Config for: nvim-rooter.lua
time([[Config for nvim-rooter.lua]], true)
try_loadstring("\27LJ\2\nG\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\30user.plugins._nvim-rooter\frequire\0", "config", "nvim-rooter.lua")
time([[Config for nvim-rooter.lua]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: nnn.nvim
time([[Config for nnn.nvim]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\bnnn\frequire\0", "config", "nnn.nvim")
time([[Config for nnn.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\nD\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\27user.plugins._gitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: git-conflict.nvim
time([[Config for git-conflict.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\17git-conflict\frequire\0", "config", "git-conflict.nvim")
time([[Config for git-conflict.nvim]], false)
-- Config for: neo-tree.nvim
time([[Config for neo-tree.nvim]], true)
try_loadstring("\27LJ\2\nC\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\26user.plugins._neotree\frequire\0", "config", "neo-tree.nvim")
time([[Config for neo-tree.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\rcheck_ts\2\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd bufferline.nvim ]]

-- Config for: bufferline.nvim
try_loadstring("\27LJ\2\nF\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\29user.plugins._bufferline\frequire\0", "config", "bufferline.nvim")

time([[Sequenced loading]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead * ++once lua require("packer.load")({'vim-wordmotion', 'null-ls.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-cmp'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au CursorMoved * ++once lua require("packer.load")({'vim-matchup'}, { event = "CursorMoved *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)

vim.g.mapleader = " "

vim.g.maplocalleader = " "

require("options")
require("config._lazy")
require("keymaps")
require("autocommands")
require("lsp.setup")
require("lsp.diagnostics")
require("colorscheme")

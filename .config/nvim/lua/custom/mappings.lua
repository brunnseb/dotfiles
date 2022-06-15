local M = {}

M.ranger = {
  n = {
    ["<leader>ar"] = { "<cmd> Ranger <CR>", "open ranger" }
  }
}

M.files = {
  n = {
    ["<leader>fs"] = { "<cmd>update!<CR>", "save file" }
  }
}

M.buffer = {
  n = {
    ["<leader>bk"] = { "<cmd>bd!<Cr>", "delete buffer" },
    ["<leader>bK"] = { "<cmd>%bd|e#|bd#<Cr>", "delete all buffers" },
    ["<leader>b["] = { "<cmd>bprevious<CR>", "previous buffer" },
    ["<leader>b]"] = { "<cmd>bnext<CR>", "next buffer" },
  }
}

M.window = {
  n = {
    ["<leader>wh"] = { "<C-w>h", "switch to left window" },
    ["<leader>wj"] = { "<C-w>j", "switch to bottom window" },
    ["<leader>wl"] = { "<C-w>l", "switch to right window" },
    ["<leader>wk"] = { "<C-w>k", "switch to top window" },
    ["<leader>wc"] = { "<C-w>q", "close window" },
    ["<leader>wv"] = { "<C-w>v", "split window vertically" },
    ["<leader>ws"] = { "<C-w>s", "split window horizontally" },
    ["<leader>wo"] = { "<C-w>|", "window whole width" },
    ["<leader>w="] = { "<C-w>=", "window equal width" },
  }
}

M.viviz = {
  n = {
    ["gm"] = { "<cmd>lua require('vi-viz').vizInit()<CR>", "expand region" },
  },
  x = {
    ["m"] = { "<cmd>lua require('vi-viz').vizExpand()<CR>", "expand region" },
    ["n"] = { "<cmd>lua require('vi-viz').vizContract()<CR>", "contract region" },
    ["l"] = { "<cmd>lua require('vi-viz').vizExpand1Chr()<CR>", "expand region with 1 char" },
    ["h"] = { "<cmd>lua require('vi-viz').vizContract1Chr()<CR>", "contract region with 1 char" },
  }
}

M.indent = {
  v = {
    [">"] = { ">gv", "indent right" },
    ["<"] = { "<gv", "indent left" },
  }
}

M.move = {
  x = {
    ["K"] = { ":move '<-2<CR>gv-gv", "move line up" },
    ["J"] = { ":move '>+1<CR>gv-gv", "move line down" },
  }
}

return M

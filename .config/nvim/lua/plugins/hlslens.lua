return {
  {
    "kevinhwang91/nvim-hlslens",
    dependencies = { "haya14busa/vim-asterisk" },
    event = "BufEnter",
    config = function()
      local hlslens = require("hlslens")
      hlslens.setup({
        override_lens = function(render, posList, nearest, idx, relIdx)
          local sfw = vim.v.searchforward == 1
          local indicator, text, chunks
          local absRelIdx = math.abs(relIdx)
          if absRelIdx > 1 then
            indicator = ("%d%s"):format(absRelIdx, (relIdx > 1) and "▼" or "▲")
          elseif absRelIdx == 1 then
            indicator = (relIdx == 1) and "▼" or "▲"
          else
            indicator = ""
          end

          local lnum, col = unpack(posList[idx])
          if nearest then
            local cnt = #posList
            if indicator ~= "" then
              text = ("[%s %d/%d]"):format(indicator, idx, cnt)
            else
              text = ("[%d/%d]"):format(idx, cnt)
            end
            chunks = { { " ", "Ignore" }, { text, "HlSearchLensNear" } }
          else
            text = ("[%s %d]"):format(indicator, idx)
            chunks = { { " ", "Ignore" }, { text, "HlSearchLens" } }
          end
          render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
        end,

        calm_down = true,
      })

      vim.api.nvim_set_keymap("n", "*", [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap("n", "#", [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap("n", "g*", [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap("n", "g#", [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], {})

      vim.api.nvim_set_keymap("x", "*", [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap("x", "#", [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap("x", "g*", [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap("x", "g#", [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], {})
    end,
  },
}

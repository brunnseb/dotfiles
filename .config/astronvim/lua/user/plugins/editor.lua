return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewToggleFiles", "DiffviewFileHistory", "DiffviewLog" },
  },
  { "anuvyklack/hydra.nvim" },
  {
    "nvim-neotest/neotest",
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-vitest",
        },
      }
    end,
    dependencies = {
      "marilari88/neotest-vitest",
    },
  },
  {
    "nvim-pack/nvim-spectre",
    opts = function(_, opts)
      opts.result_padding = "⏐  "
      opts.mapping = vim.tbl_deep_extend("force", opts.mapping, {
        ["send_to_qf"] = {
          map = "Q",
          cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          desc = "send all item to quickfix",
        },
      })

      return opts
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.filesystem.filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
      }

      return opts
    end,
  },
  {
    "uga-rosa/translate.nvim",
    cmd = { "Translate" },
    opts = {
      default = {
        output = "replace",
        parse_before = "concat,trim,natural",
      },
    },
  },
  {
    "anuvyklack/windows.nvim",
    cmd = {
      "WindowsMaximize",
      "WindowsMaximizeVertically",
      "WindowsMaximizeHorizontally",
      "WindowsEqualize",
      "WindowsEnableAutowidth",
      "WindowsDisableAutowidth",
      "WindowsToggleAutowidth",
    },
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    config = function(plugin, opts)
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("  %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end

      require("ufo").setup {
        fold_virt_text_handler = handler,
        ---@diagnostic disable-next-line: assign-type-mismatch
        close_fold_kinds = { "imports", "comment" },
      }
      -- buffer scope handler
      -- will override global handler if it is existed
      local bufnr = vim.api.nvim_get_current_buf()
      require("ufo").setFoldVirtTextHandler(bufnr, handler)
    end,
  },
  { "luukvbaal/nnn.nvim", cmd = { "NnnPicker", "NnnExplorer" }, config = true },
}

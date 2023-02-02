return {
  {
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
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

      require("ufo").setup({
        fold_virt_text_handler = handler,
        close_fold_kinds = { "imports", "comment" },
      })
      -- buffer scope handler
      -- will override global handler if it is existed
      local bufnr = vim.api.nvim_get_current_buf()
      require("ufo").setFoldVirtTextHandler(bufnr, handler)
    end,
  },
  {
    "nmac427/guess-indent.nvim",
    config = true,
  },
  {
    "max397574/better-escape.nvim",
    config = true,
  },
  { "chaoren/vim-wordmotion" },
  {
    "axelvc/template-string.nvim",
    config = function()
      require("template-string").setup({})
    end,
  },
  { "gaelph/logsitter.nvim", dependencies = { "nvim-treesitter/nvim-treesitter" } },
  {
    "kylechui/nvim-surround",
    config = true,
  },
  { "ggandor/lightspeed.nvim", opts = {
    ignore_case = true,
  } },
  { "andymass/vim-matchup" },
  { "mg979/vim-visual-multi" },
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
    "notjedi/nvim-rooter.lua",
    config = function()
      require("nvim-rooter").setup({
        rooter_patterns = { "=cockpit-portal", "lazy-lock.json", ".vscode", ".git" },
        trigger_patterns = { "*" },
        manual = false,
      })
    end,
  },
}

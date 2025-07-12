-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.bars-and-lines.scope-nvim" },
  { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
  { import = "astrocommunity.code-runner.overseer-nvim" },
  { import = "astrocommunity.comment.ts-comments-nvim" },
  -- { import = "astrocommunity.completion.blink-cmp" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.docker.lazydocker" },
  { import = "astrocommunity.editing-support.bigfile-nvim" },

  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },

  { import = "astrocommunity.editing-support.conform-nvim" },
  { import = "astrocommunity.editing-support.mcphub-nvim" },
  { import = "astrocommunity.editing-support.mini-operators" },
  { import = "astrocommunity.editing-support.vim-visual-multi" },
  { import = "astrocommunity.editing-support.nvim-origami" },
  { import = "astrocommunity.editing-support.nvim-treesitter-context" },
  -- { import = "astrocommunity.editing-support.quick-scope" },
  { import = "astrocommunity.editing-support.refactoring-nvim" },
  { import = "astrocommunity.editing-support.suda-vim" },
  { import = "astrocommunity.editing-support.text-case-nvim" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },

  { import = "astrocommunity.fuzzy-finder.snacks-picker" },
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.git.neogit" },
  -- { import = "astrocommunity.icon.mini-icons" },
  { import = "astrocommunity.indent.snacks-indent-hlchunk" },

  -- { import = "astrocommunity.lsp.delimited-nvim" },
  { import = "astrocommunity.lsp.dev-tools-nvim" },
  { import = "astrocommunity.lsp.lsp-lens-nvim" },
  { import = "astrocommunity.lsp.lsplinks-nvim" },
  { import = "astrocommunity.lsp.nvim-lsp-endhints" },
  { import = "astrocommunity.lsp.ts-error-translator-nvim" },
  -- { import = "astrocommunity.lsp.sonarlint-nvim" },
  { import = "astrocommunity.lsp.nvim-lsp-file-operations" },

  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.mini-ai" },
  { import = "astrocommunity.motion.mini-move" },
  { import = "astrocommunity.motion.nvim-spider" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.nvim-tree-pairs" },
  { import = "astrocommunity.motion.portal-nvim" },
  { import = "astrocommunity.motion.tabout-nvim" },

  { import = "astrocommunity.neovim-lua-development.helpview-nvim" },

  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.eslint" },
  { import = "astrocommunity.pack.fish" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.nginx" },
  { import = "astrocommunity.pack.nvchad-ui" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.xml" },
  { import = "astrocommunity.pack.yaml" },

  { import = "astrocommunity.programming-language-support.nvim-jqx" },
  { import = "astrocommunity.project.projectmgr-nvim" },

  { import = "astrocommunity.quickfix.quicker-nvim" },

  -- { import = "astrocommunity.recipes.ai" },
  -- { import = "astrocommunity.recipes.astrolsp-no-insert-inlay-hints" },
  { import = "astrocommunity.recipes.heirline-nvchad-statusline" },
  -- { import = "astrocommunity.recipes.picker-lsp-mappings" },
  { import = "astrocommunity.recipes.picker-nvchad-theme" },

  { import = "astrocommunity.scrolling.cinnamon-nvim" },

  { import = "astrocommunity.search.grug-far-nvim" },
  { import = "astrocommunity.search.nvim-hlslens" },

  { import = "astrocommunity.split-and-window.colorful-winsep-nvim" },
  { import = "astrocommunity.split-and-window.mini-map" },

  { import = "astrocommunity.test.neotest" },

  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.split-and-window.edgy-nvim" },
  -- import/override with your plugins folder
}

return {
  {
    "mg979/vim-visual-multi",
    event = "BufEnter",
    init = function()
      -- -- Vim Multi Cursor Highlights
      -- vim.g.VM_Mono_hl = "MultiCursorMono"
      -- vim.g.VM_Extend_hl = "MultiCursorExtend"
      -- vim.g.VM_Cursor_hl = "MultiCursorCursor"
      -- vim.g.VM_Insert_hl = "MultiCursorInsert"

      vim.g.VM_leader = ","
      vim.g.VM_maps = {
        ["Add Cursor Down"] = ",<Down>",
        ["Add Cursor Up"] = ",<Up>",
        ["Add Cursor At Pos"] = ",,",
        ["Motion ,"] = ",;",
        ["Undo"] = "u",
        ["Redo"] = "<C-r>",
        ["I Return"] = "<S-CR>",
        ["I Down Arrow"] = "",
        ["I Up Arrow"] = "",
      }
    end,
  },
}

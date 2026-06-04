-- local function ensure_ts_bridge_daemon()
--   if vim.g.ts_bridge_daemon_started then
--     return
--   end
--   vim.g.ts_bridge_daemon_started = true
--   vim.fn.jobstart({
--     "ts-bridge",
--     "daemon",
--     "--listen",
--     "127.0.0.1:7007", -- choose your port
--     "--idle-ttl",
--     "30m",
--   }, {
--     detach = true,
--     env = { RUST_LOG = "info" },
--   })
-- end
--
-- local function wait_for_daemon(host, port, timeout_ms)
--   local addr = string.format("%s:%d", host, port)
--   local function is_ready()
--     local ok, chan = pcall(vim.fn.sockconnect, "tcp", addr, { rpc = false })
--     if not ok then
--       return false
--     end
--     if type(chan) == "number" and chan > 0 then
--       vim.fn.chanclose(chan)
--       return true
--     end
--     return false
--   end
--   return vim.wait(timeout_ms, is_ready, 50)
-- end
--
-- local function daemon_cmd(dispatchers)
--   ensure_ts_bridge_daemon()
--   -- Built-in LSP has no `on_new_config`, and `before_init` runs after `cmd`, so
--   -- start + wait here to avoid a first-attach connection refusal.
--   wait_for_daemon("127.0.0.1", 7007, 2000)
--   return vim.lsp.rpc.connect("127.0.0.1", 7007)(dispatchers)
-- end

-- vim.lsp.config("ts_bridge", {
--   cmd = daemon_cmd,
--   filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
--   root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
-- })

-- vim.lsp.enable("ts_bridge")

return {

  {
    "dmmulroy/tsc.nvim",
    opts = {
      auto_start_watch_mode = false,
      use_trouble_qflist = false,
      flags = {
        watch = false,
      },
    },
    keys = {
      { "<leader>ct", ft = { "typescript", "typescriptreact" }, "<cmd>TSC<cr>", desc = "Type Check" },
    },
    ft = {
      "typescript",
      "typescriptreact",
    },
    cmd = {
      "TSC",
      "TSCOpen",
      "TSCClose",
    },
  },
}

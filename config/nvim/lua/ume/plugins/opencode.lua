return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    { "folke/snacks.nvim", opts = { input = {} } },
  },
  config = function()
    local opencode = require("opencode")
    local ok, local_overrides = pcall(require, "ume.config.local-overrides")
    local local_opts = (ok and local_overrides.opencode) or {}

    vim.g.opencode_opts = vim.tbl_deep_extend("force", {
      port = 41993,
    }, local_opts)

    vim.o.autoread = true

    vim.keymap.set({ "n", "v" }, "<leader>oc", function()
      opencode.select()
    end, { desc = "OpenCode actions" })
    vim.keymap.set("n", "<leader>ot", function()
      opencode.toggle()
    end, { desc = "Toggle OpenCode" })
  end,
}

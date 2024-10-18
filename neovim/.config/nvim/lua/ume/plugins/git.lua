return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local gitsigns = require("gitsigns")

    gitsigns.setup({
      on_attach = function()
        gitsigns.toggle_current_line_blame()
      end,
    })
  end,
}

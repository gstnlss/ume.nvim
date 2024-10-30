return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gitsigns = require("gitsigns")

      gitsigns.setup({
        on_attach = function()
          gitsigns.toggle_current_line_blame()
        end,
      })
    end,
  },
  {
    "tpope/vim-fugitive",
    config = function()
      local utils = require("ume.utils")
      local keymaps = {
        { "n", "<leader>gs", "<CMD>Git<CR>" },
        { "n", "<leader>gb", "<CMD>Git blame<CR>" },
      }

      utils.set_keymaps(keymaps)
    end,
  },
}

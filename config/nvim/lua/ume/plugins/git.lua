return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gitsigns = require("gitsigns")

      gitsigns.setup()
    end,
  },
  {
    "tpope/vim-fugitive",
    config = function()
      local utils = require("ume.utils")
      local keymaps = {
        { "n", "<leader>gs", ":Git<CR>" },
        { "n", "<leader>gb", ":Git blame<CR>" },
        { "n", "<leader>gc", ":Telescope git_branches<CR>" },
      }

      utils.set_keymaps(keymaps)
    end,
  },
}

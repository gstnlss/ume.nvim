return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      local utils = require("ume.utils")

      local keymaps = {
        { "n", "<leader>ee", "<CMD>Neotree filesystem reveal left toggle<CR>" },
        { "n", "<leader>eb", "<CMD>Neotree buffers reveal left toggle<CR>" },
        { "n", "<leader>ec", "<CMD>Neotree git_status reveal left toggle<CR>" },
      }

      utils.set_keymaps(keymaps)
    end,
  },
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      require("window-picker").setup()
    end,
  },
}

return {
  "rmagatti/auto-session",
  lazy = false,
  config = function()
    require("auto-session").setup({
      suppressed_dirs = { "~/", "~/Downloads", "~/.config/", "/" },
      bypass_save_filetypes = { "alpha", "neo-tree" },
    })

    local utils = require("ume.utils")
    utils.set_keymaps({
      { "n", "<leader>ss", "<CMD>SessionSearch<CR>" },
      { "n", "<leader>sw", "<CMD>SessionSave<CR>" },
    })
  end,
}

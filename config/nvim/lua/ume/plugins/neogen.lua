return {
  "danymat/neogen",
  config = function()
    local neogen = require("neogen")
    local utils = require("ume.utils")
    local keymap_options = {
      noremap = true,
      silent = true,
      desc = "Generate documentation with Neogen",
    }

    neogen.setup({ snippet_engine = "mini" })

    utils.set_keymaps({
      { "n", "<Leader>dg", neogen.generate, keymap_options },
    })
  end,
}

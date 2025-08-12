return {
  "danymat/neogen",
  config = function()
    local neogen = require("neogen")
    local utils = require("ume.utils")
    local keymap_options = { noremap = true, silent = true }

    neogen.setup({ snippet_engine = "luasnip" })

    utils.set_keymaps({
      { "n", "<Leader>dg", neogen.generate, keymap_options },
    })
  end,
}

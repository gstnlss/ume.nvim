return {
  "danymat/neogen",
  config = function()
    local neogen = require("neogen")

    neogen.setup({ snippet_engine = "mini" })

    vim.keymap.set("n", "<Leader>dg", neogen.generate, {
      noremap = true,
      silent = true,
      desc = "Generate documentation with Neogen",
    })
  end,
}

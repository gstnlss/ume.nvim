return {
  "David-Kunz/gen.nvim",
  config = function()
    local gen = require("gen")
    local utils = require("ume.utils")

    gen.setup({
      model = "llama3.2",
      show_model = true,
    })

    utils.set_keymaps({
      { { "n", "v" }, "<leader>ai", "<CMD>Gen<CR>" },
      { "n", "<leader>ac", "<CMD>Gen Chat<CR>" },
      {
        { "n", "v" },
        "<leader>as",
        function()
          require("gen").select_model()
        end,
      },
    })
  end,
}

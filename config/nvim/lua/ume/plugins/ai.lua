return {
  "David-Kunz/gen.nvim",
  config = function()
    local gen = require("gen")
    local utils = require("ume.utils")

    gen.setup({
      model = "qwen2.5-coder:14b",
      show_prompt = true,
      show_model = true,
    })

    utils.set_keymaps({
      { { "n", "v" }, "<leader>ai", ":Gen<CR>" },
      { "n", "<leader>ac", ":Gen Chat<CR>" },
      { { "n", "v" }, "<leader>as", gen.select_model },
    })
  end,
}

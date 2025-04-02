local function preferred_model_picker(preferred)
  return function(self)
    if self == nil then
      -- Debug:render() calls Adapter.schema.model.default() but doesn't pass
      -- in `self`. Just return an empty string in this case.
      return ""
    end

    local choices = self.schema.model.choices(self)

    for _, best in ipairs(preferred) do
      for _, choice in ipairs(choices) do
        if choice:find(best, 1, true) then
          return choice
        end
      end
    end

    return choices[1]
  end
end

local function ollama_adapter(models)
  if type(models) ~= "table" then
    models = { models }
  end

  return require("codecompanion.adapters").extend("ollama", {
    schema = {
      model = {
        default = preferred_model_picker(models),
      },
    },
  })
end

return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local companion = require("codecompanion")
      local utils = require("ume.utils")

      companion.setup({
        strategies = {
          chat = { adapter = "qwen" },
          inline = { adapter = "qwen" },
        },
        adapters = {
          opts = {
            show_defaults = false,
          },
          qwen = ollama_adapter({ "qwen2.5-coder:14b", "qwen2.5-coder:7b" }),
          llama = ollama_adapter("llama3.2:3b"),
          codellama = ollama_adapter("codellama:13b"),
          codegemma = ollama_adapter("codegemma:7b"),
        },
      })

      utils.set_keymaps({
        { { "n", "v" }, "<leader>ai", ":CodeCompanionActions<CR>" },
        { { "n", "v" }, "<leader>ac", ":CodeCompanionChat<CR>" },
        { { "n", "v" }, "<leader>at", ":CodeCompanionChat Toggle<CR>" },
        { { "n", "v" }, "<leader>aq", ":CodeCompanion " },
      })
    end,
  },
}

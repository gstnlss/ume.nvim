-- Choose default model from a list of preferred models. Fall back to first
-- available.
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
          chat = { adapter = "ollama" },
          inline = { adapter = "ollama_inline" },
        },
        adapters = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              schema = {
                model = {
                  default = preferred_model_picker({
                    "qwen2.5-coder:14b",
                    "qwen2.5-coder:7b",
                    "qwen2.5-coder:3b",
                    "qwen2.5-coder:1.5b",
                    "qwen2.5-coder:0.5b",
                  }),
                },
              },
            })
          end,
          ollama_inline = function()
            return require("codecompanion.adapters").extend("ollama", {
              schema = {
                model = {
                  default = "qwen2.5-coder:1.5b",
                },
              },
            })
          end,
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

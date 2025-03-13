local function custom_components()
  local components = {
    codecompanion = require("lualine.component"):extend(),
  }

  components.codecompanion.processing = false
  components.codecompanion.spinner_index = 1

  local spinner_symbols = {
    "⠋",
    "⠙",
    "⠹",
    "⠸",
    "⠼",
    "⠴",
    "⠦",
    "⠧",
    "⠇",
    "⠏",
  }
  local spinner_symbols_len = 10

  function components.codecompanion:init(options)
    components.codecompanion.super.init(self, options)

    local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "CodeCompanionRequest*",
      group = group,
      callback = function(request)
        if request.match == "CodeCompanionRequestStarted" then
          self.processing = true
        elseif request.match == "CodeCompanionRequestFinished" then
          self.processing = false
        end
      end,
    })
  end

  -- Function that runs every time statusline is updated
  function components.codecompanion:update_status()
    if self.processing then
      self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
      return spinner_symbols[self.spinner_index]
    else
      return nil
    end
  end

  return components
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local components = custom_components()

    require("lualine").setup({
      options = {
        theme = "auto",
        section_separators = "",
        component_separators = "",
        disabled_filetypes = { "neo-tree" },
        globalstatus = true,
      },
      sections = {
        lualine_c = { "filename", components.codecompanion },
      },
    })
  end,
}

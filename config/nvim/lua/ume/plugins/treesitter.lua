return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")

    config.setup({
      -- Explicitly list parsers instead of auto_install to prevent silent failures
      -- when C compiler is not available
      ensure_installed = {
        -- Core Neovim parsers
        "lua",
        "vim",
        "vimdoc",
        "query",
        -- Programming languages (based on LSP servers in lsp.lua)
        "javascript",
        "typescript",
        "tsx",
        "ruby",
        "rust",
        "c",
        "cpp",
        "perl",
        -- Markup/data languages
        "json",
        "html",
        "css",
        "bash",
        -- Additional useful parsers
        "markdown",
        "markdown_inline",
        "regex",
      },
      -- Disable auto_install to prevent silent failures
      auto_install = false,
      highlight = {
        enable = true,
        -- Disable vim regex highlighting for better performance
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    })
  end,
}

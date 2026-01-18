-- Mason provides automatic installation of LSP servers, formatters, and linters
-- This ensures fresh installations work out of the box without manual tool installation
return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        -- Automatically install LSP servers referenced in lua/ume/config/lsp.lua
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "bashls",
          "ruby_lsp",
          "rust_analyzer",
          "jsonls",
          "html",
          "cssls",
          "eslint",
          "tailwindcss",
          "clangd",
          "perlnavigator",
        },
        -- Automatically install servers when added to ensure_installed
        automatic_installation = true,
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        -- Automatically install formatters and linters
        ensure_installed = {
          -- Formatters (from conform.lua)
          "stylua",
          "rubocop",
          "prettierd",
          "shellharden",
          -- Linters (from nvim-lint.lua)
          "luacheck",
          "shellcheck",
          "haml-lint",
          -- Note: 'ruby' linter uses built-in `ruby -c` (requires Ruby installation)
        },
        -- Automatically update tools
        auto_update = false,
        -- Install tools on startup
        run_on_start = true,
      })
    end,
  },
}

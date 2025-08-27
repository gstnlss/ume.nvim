local js_formatters = { "prettierd" }

return {
  "stevearc/conform.nvim",
  opts = {
    format_on_save = {
      timeout_ms = 1000,
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      lua = { "stylua" },
      ruby = { "rubocop" },
      javascript = js_formatters,
      javascriptreact = js_formatters,
      typescript = js_formatters,
      typescriptreact = js_formatters,
      json = { "prettierd" },
      sh = { "shellharden" },
      bash = { "shellharden" },
    },
  },
}

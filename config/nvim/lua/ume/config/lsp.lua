-- Configure bashls with additional filetypes
vim.lsp.config("bashls", {
  filetypes = { "sh", "bash", "zsh" },
})

-- Enable all configured LSP clients
vim.lsp.enable({
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
  "perlls",
})

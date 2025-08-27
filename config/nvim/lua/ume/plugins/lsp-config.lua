return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.config("bashls", {
      filetypes = { "sh", "bash", "zsh" },
    })
  end,
}

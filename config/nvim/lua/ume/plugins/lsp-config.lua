return {
  "neovim/nvim-lspconfig",
  dependencies = { "hrsh7th/cmp-nvim-lsp", "nvim-telescope/telescope.nvim" },
  config = function()
    vim.lsp.config("bashls", {
      filetypes = { "sh", "bash", "zsh" },
    })
  end,
}

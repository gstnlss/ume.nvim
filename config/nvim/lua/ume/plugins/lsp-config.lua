return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "rust_analyzer" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "nvim-telescope/telescope.nvim" },
    config = function()
      local utils = require("ume.utils")
      local telescope_builtin = require("telescope.builtin")

      vim.lsp.config("bashls", {
        filetypes = { "sh", "bash", "zsh" },
      })

      vim.lsp.enable({ "lua_ls", "rust_analyzer", "bashls", "solargraph", "ts_ls" })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local keymaps = {
            ["textDocument/rename"] = { "n", "<leader>lr", vim.lsp.buf.rename },
            ["textDocument/implementation"] = { "n", "gi", telescope_builtin.lsp_implementations },
            ["textDocument/references"] = { "n", "gr", telescope_builtin.lsp_references },
            ["textDocument/definition"] = { "n", "gd", telescope_builtin.lsp_definitions },
            ["textDocument/declaration"] = { "n", "gD", vim.lsp.buf.declaration },
            ["textDocument/codeAction"] = { "n", "<leader>ca", vim.lsp.buf.code_action },
          }

          utils.set_lsp_keymaps(args.data.client_id, keymaps)
        end,
      })
    end,
  },
}

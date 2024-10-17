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
        ensure_installed = { "lua_ls", "ansiblels" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local utils = require("ume.utils")
      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({})
      lspconfig.ansiblels.setup({})

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local keymaps = {
            ["textDocument/rename"] = { "n", "<leader>lr", vim.lsp.buf.rename },
            ["textDocument/implementation"] = { "n", "gi", vim.lsp.buf.implementation },
            ["textDocument/references"] = { "n", "gr", vim.lsp.buf.references },
            ["textDocument/codeAction"] = { "n", "<leader>ca", vim.lsp.buf.code_action },
            ["textDocument/formatting"] = {
              "n",
              "<leader>lf",
              function()
                vim.lsp.buf.format({
                  async = false,
                  filter = function(client)
                    return client.name == "null-ls"
                  end,
                })
              end,
            },
          }

          utils.set_lsp_keymaps(args.data.client_id, keymaps)
        end,
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettierd.with({
            extra_filetypes = { "yaml.ansible" },
          }),
          null_ls.builtins.diagnostics.ansiblelint,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end,
      })
    end,
  },
}

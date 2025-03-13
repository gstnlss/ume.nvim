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
        ensure_installed = { "lua_ls", "ansiblels", "ts_ls", "bashls", "rust_analyzer" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "nvim-telescope/telescope.nvim" },
    config = function()
      local utils = require("ume.utils")
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local telescope_builtin = require("telescope.builtin")

      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.ansiblels.setup({ capabilities = capabilities })
      lspconfig.bashls.setup({ capabilities = capabilities, filetypes = { "sh", "bash", "zsh" } })
      lspconfig.rust_analyzer.setup({ capabilities = capabilities })
      lspconfig.ruby_lsp.setup({ capabilities = capabilities }) -- better to install manually because of version conflicts

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local keymaps = {
            ["textDocument/rename"] = { "n", "<leader>lr", vim.lsp.buf.rename },
            ["textDocument/implementation"] = { "n", "gi", telescope_builtin.lsp_implementations },
            ["textDocument/references"] = { "n", "gr", telescope_builtin.lsp_references },
            ["textDocument/definition"] = { "n", "gd", telescope_builtin.lsp_definitions },
            ["textDocument/declaration"] = { "n", "gD", vim.lsp.buf.declaration },
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
    dependencies = { "nvimtools/none-ls-extras.nvim" },
    config = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettierd.with({
            extra_filetypes = { "yaml.ansible" },
          }),
          require("none-ls.formatting.eslint_d"),
          require("none-ls.formatting.rustfmt"),
          null_ls.builtins.formatting.rubocop,
          null_ls.builtins.formatting.opentofu_fmt,
          null_ls.builtins.diagnostics.ansiblelint,
          require("none-ls.diagnostics.eslint_d"),
          null_ls.builtins.diagnostics.rubocop,
          null_ls.builtins.diagnostics.haml_lint,
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
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup({
        settings = {
          expose_as_code_action = "all",
          jsx_close_tag = {
            enable = true,
          },
        },
      })
    end,
  },
}

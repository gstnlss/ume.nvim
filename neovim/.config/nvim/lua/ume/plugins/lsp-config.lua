return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls' }
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local utils = require('ume.utils')
      local lspconfig = require('lspconfig')

      lspconfig.lua_ls.setup({})

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local keymaps = {
            ['textDocument/rename'] = { 'n', '<leader>lr', vim.lsp.buf.rename },
            ['textDocument/implementation'] = { 'n', 'gi', vim.lsp.buf.implementation },
            -- ['textDocument/definition'] = { 'n', 'gd', vim.lsp.buf.definition },
            ['textDocument/references'] = { 'n', 'gr', vim.lsp.buf.references },
            ['textDocument/codeAction'] = { 'n', '<leader>ca', vim.lsp.buf.code_action },
            ['textDocument/formatting'] = { 'n', '<leader>lf', function()
              vim.lsp.buf.format({ async = false })
            end
            },
          }

          utils.set_lsp_keymaps(args.data.client_id, keymaps)
        end,
      })
    end
  }
}

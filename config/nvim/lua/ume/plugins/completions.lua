return {
  {
    "gstnlss/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              local entry = cmp.get_selected_entry()
              if not entry then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              end
              cmp.confirm()
            else
              fallback()
            end
          end, { "i", "s", "c" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        experimental = {
          ghost_text = true,
        },
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      -- TODO: This might be a better option: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
      local ls = require("luasnip")
      local utils = require("ume.utils")
      local keymap_options = { silent = true }

      utils.set_keymaps({
        {
          { "i", "s" },
          "<Tab>",
          function()
            ls.jump(1)
          end,
          keymap_options,
        },
        {
          { "i", "s" },
          "<S-Tab>",
          function()
            ls.jump(-1)
          end,
          keymap_options,
        },
      })
    end,
  },
}

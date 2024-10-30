return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'auto',
        section_separators = '',
        component_separators = '',
        disabled_filetypes = { 'neo-tree' },
        globalstatus = true
      },
    })
  end
}

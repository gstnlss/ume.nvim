
return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local utils = require('ume.utils')
    local builtin = require('telescope.builtin')

    local keymaps = {
      { 'n', '<leader>ff', builtin.find_files },
      { 'n', '<leader>fg', builtin.live_grep },
      { 'n', '<leader>fb', builtin.buffers },
      { 'n', '<leader>fh', builtin.help_tags }
    }

    utils.set_keymaps(keymaps)
  end
}

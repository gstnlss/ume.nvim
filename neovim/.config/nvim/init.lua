local utils = require('ume.utils')

-- Keymaps
local keymaps = {
  { 'n', '<leader>tn', '<CMD>tabnew<CR>' },
  { 'n', '<leader>tc', '<CMD>tabclose<CR>' },
  { 'n', '<leader>th', '<CMD>tabprevious<CR>' },
  { 'n', '<leader>tl', '<CMD>tabnext<CR>' },
}

utils.set_keymaps(keymaps)

require('ume')

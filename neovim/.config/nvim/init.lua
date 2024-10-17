local utils = require('ume.utils')

vim.g.mapleader = ' '
vim.g.maplocalleader = "\\"

-- Options
local options = {
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  cursorline = true,
  number = true,
  relativenumber = true,
  wrap = false,
  scrolloff = 8,
  sidescrolloff = 8,
  termguicolors = true,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- Keymaps
local keymaps = {
  { 'n', '<leader>ee', '<CMD>Vexplore<CR>' },
  { 'n', '<leader>ef', '<CMD>Vexplore %:p:h<CR>' },
  { 'n', '<leader>b', '<CMD>buffers<CR>:buffer ' },
  { 'n', '<leader>tn', '<CMD>tabnew<CR>' },
  { 'n', '<leader>tc', '<CMD>tabclose<CR>' },
  { 'n', '<leader>th', '<CMD>tabprevious<CR>' },
  { 'n', '<leader>tl', '<CMD>tabnext<CR>' },
}

utils.set_keymaps(keymaps)

-- Netrw
vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = 30
vim.g.netrw_banner = 0
-- vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4

vim.cmd[[au FileType netrw setl bufhidden=wipe]]

require('ume')

vim.cmd[[colorscheme tokyonight]]

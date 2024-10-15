vim.g.mapleader = ' '

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
  termguicolors = true
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.keymap.set('n', '<leader>e', '<CMD>e .<CR>')
vim.keymap.set('n', '<leader>b', '<CMD>buffers<CR>:buffer ')

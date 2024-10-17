vim.g.mapleader = ' '
vim.g.maplocalleader = "\\"

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

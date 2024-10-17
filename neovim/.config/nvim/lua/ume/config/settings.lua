vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local options = {
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  cursorline = true,
  number = true,
  relativenumber = true,
  wrap = false,
  scrolloff = 8,
  sidescrolloff = 8,
  termguicolors = true,
  signcolumn = "yes",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

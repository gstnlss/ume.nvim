local global_editor_options = {
  mapleader = " ",
  maplocalleader = "\\",
  -- Disable unused language providers for faster startup
  -- Note: LSP servers and external tools (rubocop, formatters, linters) run independently
  -- and do NOT require these providers. Providers are only needed for legacy remote plugins.
  loaded_python3_provider = 0,
  loaded_ruby_provider = 0,
  loaded_perl_provider = 0,
  loaded_node_provider = 0,
}

for k, v in pairs(global_editor_options) do
  vim.g[k] = v
end

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
  updatetime = 100,
  sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions",
  swapfile = false,
  mouse = "",
  mousescroll = "ver:0,hor:0",
  undofile = true,
  clipboard = "unnamedplus",
  ignorecase = true,
  smartcase = true,
  smartindent = true,
  foldmethod = "indent",
  foldlevelstart = 99,
  completeopt = "menuone,noselect,fuzzy",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

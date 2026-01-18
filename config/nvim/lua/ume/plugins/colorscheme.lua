return {
  "morhetz/gruvbox",
  -- Load colorscheme before other plugins to prevent flash
  priority = 1000,
  lazy = false,
  config = function()
    vim.g.gruvbox_italics = 1
    vim.cmd.colorscheme("gruvbox")
  end,
}

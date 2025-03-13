local utils = require("ume.utils")

local keymaps = {
  { "n", "<leader>q", ":wqall<CR>" },
  -- tab keymaps
  { "n", "<leader>tn", ":tabnew<CR>" },
  { "n", "<leader>tc", ":tabclose<CR>" },
  { "n", "[t", ":tabprevious<CR>" },
  { "n", "]t", ":tabnext<CR>" },
  -- buffer keymaps
  {
    "n",
    "<leader>bd",
    function()
      vim.cmd([[Neotree close]])
      vim.cmd([[bdelete]])
    end,
  },
  {
    "n",
    "<leader>bc",
    function()
      vim.cmd([[%bd|e#]])
      local no_name_buf = vim.fn.bufnr("$")
      vim.api.nvim_buf_delete(no_name_buf, {})
    end,
  },
  { "n", "[b", ":bprevious<CR>" },
  { "n", "]b", ":bnext<CR>" },
}

utils.set_keymaps(keymaps)

local utils = require("ume.utils")

local keymaps = {
  { "n", "<leader>q", "<CMD>wqall<CR>" },
  -- tab keymaps
  { "n", "<leader>tn", "<CMD>tabnew<CR>" },
  { "n", "<leader>tc", "<CMD>tabclose<CR>" },
  { "n", "<leader>th", "<CMD>tabprevious<CR>" },
  { "n", "<leader>tl", "<CMD>tabnext<CR>" },
  -- buffer keymaps
  { "n", "<leader>bd", "<CMD>bdelete<CR>" },
  {
    "n",
    "<leader>bc",
    function()
      vim.cmd([[%bd|e#]])
      local no_name_buf = vim.fn.bufnr("$")
      vim.api.nvim_buf_delete(no_name_buf, {})
    end,
  },
}

utils.set_keymaps(keymaps)

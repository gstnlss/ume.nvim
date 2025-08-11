local utils = require("ume.utils")
local snacks = require("snacks")

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
      snacks.bufdelete()
    end,
  },
  {
    "n",
    "<leader>bc",
    function()
      snacks.bufdelete.all()
    end,
  },
  { "n", "[b", ":bprevious<CR>" },
  { "n", "]b", ":bnext<CR>" },
}

utils.set_keymaps(keymaps)

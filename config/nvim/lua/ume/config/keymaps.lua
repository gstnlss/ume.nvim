local snacks = require("snacks")

vim.keymap.set("n", "<leader>qq", ":wqall<CR>", { desc = "Quit Neovim" })
vim.keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "Open quickfixlist" })
vim.keymap.set("n", "<leader>qc", ":cclose<CR>", { desc = "Close quickfixlist " })

-- tab keymaps
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "Create tab" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "[t", ":tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "]t", ":tabnext<CR>", { desc = "Next tab" })

-- buffer keymaps
vim.keymap.set("n", "<leader>bd", function()
  snacks.bufdelete()
end, { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bc", function()
  snacks.bufdelete.other()
end, { desc = "Cleanup buffers" })
vim.keymap.set("n", "[b", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "]b", ":bnext<CR>", { desc = "Next buffer" })

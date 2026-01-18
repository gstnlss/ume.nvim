return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set("n", "<leader>uu", "<CMD>UndotreeToggle<CR>", { desc = "Toggle undo tree" })
  end,
}

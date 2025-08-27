local telescope_builtin = require("telescope.builtin")

vim.lsp.enable({ "lua_ls", "ts_ls", "bashls", "solargraph", "rust_analyzer" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    vim.keymap.set("n", "grr", telescope_builtin.lsp_references)
    vim.keymap.set("n", "gri", telescope_builtin.lsp_implementations)
    vim.keymap.set("n", "grt", telescope_builtin.lsp_type_definitions)
    vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions)
  end,
})

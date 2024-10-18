return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local utils = require("ume.utils")
      local builtin = require("telescope.builtin")

      local keymaps = {
        { "n", "<leader>ff", builtin.find_files },
        { "n", "<leader>fg", builtin.live_grep },
        { "n", "<leader>fb", builtin.buffers },
        { "n", "<leader>fd", builtin.help_tags },
        { "n", "<leader>fc", builtin.git_status },
        {
          "n",
          "<leader>fh",
          function()
            builtin.find_files({ hidden = true })
          end,
        },
      }

      utils.set_keymaps(keymaps)
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}

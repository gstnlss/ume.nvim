return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    require("ibl").setup({
      scope = {
        show_start = false,
      },
    })
  end,
}

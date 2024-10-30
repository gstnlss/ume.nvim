return {
  "mbbill/undotree",
  config = function()
    local utils = require("ume.utils")
    utils.set_keymaps({
      { "n", "<leader>uu", "<CMD>UndotreeToggle<CR>" },
    })
  end,
}

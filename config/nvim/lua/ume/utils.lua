local M = {}

M.set_keymaps = function(keymaps)
  for _, keymap in ipairs(keymaps) do
    local modes = keymap[1]
    local keys = keymap[2]
    local action = keymap[3]
    local options = keymap[4] or {}

    vim.keymap.set(modes, keys, action, options)
  end
end

return M

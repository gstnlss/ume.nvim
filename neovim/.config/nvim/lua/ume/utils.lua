local M = {}

M.set_keymaps = function(keymaps)
  for _, v in ipairs(keymaps) do
    local modes = v[1]
    local keys = v[2]
    local action = v[3]
    local description = v[4] or ''

    vim.keymap.set(modes, keys, action, {
      desc = description
    })
  end
end

return M;

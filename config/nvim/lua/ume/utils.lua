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

M.set_lsp_keymaps = function(client_id, keymaps)
  local client = vim.lsp.get_client_by_id(client_id)

  for method, config in pairs(keymaps) do
    local modes = config[1]
    local keys = config[2]
    local action = config[3]
    local options = config[4] or {}

    if client:supports_method(method) then
      vim.keymap.set(modes, keys, action, options)
    else
      vim.keymap.set(modes, keys, function()
        print("[" .. method .. "] not support for client [" .. client.name .. "]")
      end, options)
    end
  end
end

return M

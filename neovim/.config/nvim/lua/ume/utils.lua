local M = {}

M.set_keymaps = function(keymaps)
  for _, v in pairs(keymaps) do
    local modes = v[1]
    local keys = v[2]
    local action = v[3]
    local options = v[4] or {}

    vim.keymap.set(modes, keys, action, options)
  end
end

M.set_lsp_keymaps = function(client_id, keymaps)
  local client = vim.lsp.get_client_by_id(client_id)

  for method, config in pairs(keymaps) do
    if client.supports_method(method) then
      local modes = config[1]
      local keys = config[2]
      local action = config[3]
      local options = config[4] or {}

      vim.keymap.set(modes, keys, action, options)
    end
  end
end

return M;

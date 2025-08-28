local MiniConfig = {}
local plugin_definition = {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.completion").setup()
    require("mini.icons").setup()
    require("mini.pairs").setup()
    require("mini.statusline").setup()
    require("mini.notify").setup()
    require("mini.move").setup()

    MiniConfig.files()
    MiniConfig.snippets()
    MiniConfig.pick()
    MiniConfig.sessions()
    MiniConfig.indentscope()
    MiniConfig.clue()
    MiniConfig.bufremove()
  end,
}

MiniConfig.files = function()
  require("mini.files").setup()
  vim.keymap.set("n", "<leader>er", MiniFiles.open, { desc = "File explorer (root)" })
  vim.keymap.set("n", "<leader>ee", function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0))
  end, { desc = "File explorer (current)" })
end

MiniConfig.snippets = function()
  local snippets = require("mini.snippets")
  local gen_loader = snippets.gen_loader
  local match_strict = function(snips)
    return snippets.default_match(snips, { pattern_fuzzy = "%S+" })
  end
  snippets.setup({
    snippets = {
      gen_loader.from_file("~/.config/nvim/snippets/global.json"),
      gen_loader.from_lang(),
    },
    mappings = { expand = "", jump_next = "", jump_prev = "" },
    expand = { match = match_strict },
  })

  -- Super tab setup
  local expand_or_jump = function()
    local can_expand = #MiniSnippets.expand({ insert = false }) > 0
    if can_expand then
      vim.schedule(MiniSnippets.expand)
      return ""
    end
    local is_active = MiniSnippets.session.get() ~= nil
    if is_active then
      MiniSnippets.session.jump("next")
      return ""
    end
    return "\t"
  end
  local jump_prev = function()
    MiniSnippets.session.jump("prev")
  end
  vim.keymap.set("i", "<Tab>", expand_or_jump, { expr = true })
  vim.keymap.set("i", "<S-Tab>", jump_prev)
end

MiniConfig.pick = function()
  require("mini.pick").setup()
  vim.keymap.set("n", "<leader>ff", ":Pick files<CR>", { desc = "Find files" })
  vim.keymap.set("n", "<leader>fb", ":Pick buffers<CR>", { desc = "Find buffers" })
  vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>", { desc = "Live grep" })
  vim.keymap.set("n", "<leader>fr", ":Pick resume<CR>", { desc = "Resume find" })
  vim.keymap.set("n", "<leader>fp", ":Pick git_files<CR>", { desc = "Find git files" })
  vim.keymap.set("n", "<leader>gc", ":Pick git_branches<CR>", { desc = "Find git branches" })

  require("mini.extra").setup()
  vim.keymap.set("n", "<leader>fc", ":Pick colorschemes<CR>", { desc = "Pick colorscheme" })
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
      vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { desc = "LSP code actions" })
      vim.keymap.set("n", "gri", ":Pick lsp scope='implementation'<CR>", { desc = "LSP implementation" })
      vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "LSP rename" })
      vim.keymap.set("n", "grr", ":Pick lsp scope='references'<CR>", { desc = "LSP references" })
      vim.keymap.set("n", "grt", ":Pick lsp scope='type_definition'<CR>", { desc = "LSP type definition" })
      vim.keymap.set("n", "gd", ":Pick lsp scope='definition'<CR>", { desc = "LSP definition" })
    end,
  })
end

MiniConfig.sessions = function()
  require("mini.sessions").setup()
  vim.keymap.set("n", "<leader>ss", function()
    MiniSessions.select()
  end, { desc = "Select session" })

  vim.keymap.set("n", "<leader>sn", function()
    local cwd = vim.fn.getcwd()
    local root_dir = vim.fn.fnamemodify(cwd, ":t")
    MiniSessions.write(root_dir)
  end, { desc = "Create session" })

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      local cwd = vim.fn.getcwd()
      local root_dir = vim.fn.fnamemodify(cwd, ":t")

      if MiniSessions.detected[root_dir] ~= nil then
        MiniSessions.read(root_dir)
      end
    end,
  })
end

MiniConfig.indentscope = function()
  local indentscope = require("mini.indentscope")
  indentscope.setup({
    draw = {
      animation = indentscope.gen_animation.none(),
    },
  })
end

MiniConfig.clue = function()
  local miniclue = require("mini.clue")
  miniclue.setup({
    triggers = {
      -- Leader triggers
      { mode = "n", keys = "<Leader>" },
      { mode = "x", keys = "<Leader>" },

      -- Built-in completion
      { mode = "i", keys = "<C-x>" },

      -- `g` key
      { mode = "n", keys = "g" },
      { mode = "x", keys = "g" },

      -- Marks
      { mode = "n", keys = "'" },
      { mode = "n", keys = "`" },
      { mode = "x", keys = "'" },
      { mode = "x", keys = "`" },

      -- Registers
      { mode = "n", keys = '"' },
      { mode = "x", keys = '"' },
      { mode = "i", keys = "<C-r>" },
      { mode = "c", keys = "<C-r>" },

      -- Window commands
      { mode = "n", keys = "<C-w>" },

      -- `z` key
      { mode = "n", keys = "z" },
      { mode = "x", keys = "z" },
    },

    clues = {
      -- Enhance this by adding descriptions for <Leader> mapping groups
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),
    },
  })
end

MiniConfig.bufremove = function()
  require("mini.bufremove").setup()
  vim.keymap.set("n", "<leader>bd", MiniBufremove.delete, { desc = "Delete current buffer" })
  vim.keymap.set("n", "<leader>bc", function()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_is_loaded(bufnr) then
        vim.cmd.bdelete(bufnr)
      end
    end
    MiniPick.builtin.files()
  end, { desc = "Cleanup buffers" })
end

return plugin_definition

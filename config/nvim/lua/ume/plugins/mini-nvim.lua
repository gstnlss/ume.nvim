local super_tab = function()
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

local minisnippets = function()
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
  super_tab()
end

local minipick = function()
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

local minisessions = function()
  require("mini.sessions").setup({
    autoread = true,
    autowrite = true,
  })
  vim.keymap.set("n", "<leader>ss", function()
    MiniSessions.select()
  end)
  vim.keymap.set("n", "<leader>sn", function()
    local cwd = vim.fn.getcwd()
    local root_dir = vim.fn.fnamemodify(cwd, ":t")
    MiniSessions.write(root_dir)
  end)
end

local minifiles = function()
  require("mini.files").setup()
  vim.keymap.set("n", "<leader>ee", MiniFiles.open)
end

local miniindentscope = function()
  local indentscope = require("mini.indentscope")
  indentscope.setup({
    draw = {
      animation = indentscope.gen_animation.none(),
    },
  })
end

local miniclue = function()
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

return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    vim.cmd.colorscheme("miniautumn")
    require("mini.completion").setup()
    require("mini.icons").setup()
    require("mini.pairs").setup()
    require("mini.statusline").setup()
    require("mini.notify").setup()
    require("mini.move").setup()

    minifiles()
    minisnippets()
    minipick()
    minisessions()
    miniindentscope()
    miniclue()
  end,
}

local MiniConfig = {}
local plugin_definition = {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.icons").setup()
    require("mini.pairs").setup()
    require("mini.statusline").setup()
    require("mini.notify").setup()
    require("mini.move").setup()
    require("mini.completion").setup()

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
  local minifiles = require("mini.files")
  minifiles.setup()
  vim.keymap.set("n", "<leader>er", minifiles.open, { desc = "File explorer (root)" })
  vim.keymap.set("n", "<leader>ee", function()
    minifiles.open(vim.api.nvim_buf_get_name(0))
  end, { desc = "File explorer (current)" })
end

MiniConfig.snippets = function()
  local snippets = require("mini.snippets")
  local gen_loader = snippets.gen_loader
  local match_strict = function(snips)
    return snippets.default_match(snips, { pattern_fuzzy = "%S+" })
  end

  -- Build loaders list, optionally including custom global snippets
  local loaders = {}

  -- Only load custom snippets if the file exists
  local custom_snippet_path = vim.fn.stdpath("config") .. "/snippets/global.json"
  if vim.fn.filereadable(custom_snippet_path) == 1 then
    table.insert(loaders, gen_loader.from_file(custom_snippet_path))
  end

  -- Always load language-specific snippets
  table.insert(loaders, gen_loader.from_lang())

  snippets.setup({
    snippets = loaders,
    mappings = { expand = "", jump_next = "", jump_prev = "" },
    expand = { match = match_strict },
  })

  -- Super tab setup
  local minisnippets = require("mini.snippets")
  local expand_or_jump = function()
    local can_expand = #minisnippets.expand({ insert = false }) > 0
    if can_expand then
      vim.schedule(minisnippets.expand)
      return ""
    end
    local is_active = minisnippets.session.get() ~= nil
    if is_active then
      minisnippets.session.jump("next")
      return ""
    end
    return "\t"
  end
  local jump_prev = function()
    minisnippets.session.jump("prev")
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

  -- Set up LSP keymaps on attach with proper buffer-local scope and capability checks
  local lsp_augroup = vim.api.nvim_create_augroup("ume_lsp_attach", { clear = true })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_augroup,
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if not client then
        return
      end

      -- Buffer-local keymap options
      local opts = { buffer = bufnr }

      -- Helper to create a fallback that notifies when method isn't supported
      local client_name = client.name
      local function unsupported_notify(method_name)
        return function()
          vim.notify(
            string.format("LSP server '%s' does not support %s", client_name, method_name),
            vim.log.levels.WARN
          )
        end
      end

      -- Set keymaps if supported, otherwise set fallback with notification
      if client:supports_method("textDocument/codeAction") then
        vim.keymap.set(
          "n",
          "gra",
          vim.lsp.buf.code_action,
          vim.tbl_extend("force", opts, { desc = "LSP code actions" })
        )
      else
        vim.keymap.set(
          "n",
          "gra",
          unsupported_notify("code actions"),
          vim.tbl_extend("force", opts, { desc = "LSP code actions (unsupported)" })
        )
      end

      if client:supports_method("textDocument/implementation") then
        vim.keymap.set(
          "n",
          "gri",
          ":Pick lsp scope='implementation'<CR>",
          vim.tbl_extend("force", opts, { desc = "LSP implementation" })
        )
      else
        vim.keymap.set(
          "n",
          "gri",
          unsupported_notify("implementation"),
          vim.tbl_extend("force", opts, { desc = "LSP implementation (unsupported)" })
        )
      end

      if client:supports_method("textDocument/rename") then
        vim.keymap.set("n", "grn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "LSP rename" }))
      else
        vim.keymap.set(
          "n",
          "grn",
          unsupported_notify("rename"),
          vim.tbl_extend("force", opts, { desc = "LSP rename (unsupported)" })
        )
      end

      if client:supports_method("textDocument/references") then
        vim.keymap.set(
          "n",
          "grr",
          ":Pick lsp scope='references'<CR>",
          vim.tbl_extend("force", opts, { desc = "LSP references" })
        )
      else
        vim.keymap.set(
          "n",
          "grr",
          unsupported_notify("references"),
          vim.tbl_extend("force", opts, { desc = "LSP references (unsupported)" })
        )
      end

      if client:supports_method("textDocument/typeDefinition") then
        vim.keymap.set(
          "n",
          "grt",
          ":Pick lsp scope='type_definition'<CR>",
          vim.tbl_extend("force", opts, { desc = "LSP type definition" })
        )
      else
        vim.keymap.set(
          "n",
          "grt",
          unsupported_notify("type definition"),
          vim.tbl_extend("force", opts, { desc = "LSP type definition (unsupported)" })
        )
      end

      if client:supports_method("textDocument/definition") then
        vim.keymap.set(
          "n",
          "gd",
          ":Pick lsp scope='definition'<CR>",
          vim.tbl_extend("force", opts, { desc = "LSP definition" })
        )
      else
        vim.keymap.set(
          "n",
          "gd",
          unsupported_notify("definition"),
          vim.tbl_extend("force", opts, { desc = "LSP definition (unsupported)" })
        )
      end

      if client:supports_method("textDocument/hover") then
        vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP hover" }))
      else
        vim.keymap.set(
          "n",
          "K",
          unsupported_notify("hover"),
          vim.tbl_extend("force", opts, { desc = "LSP hover (unsupported)" })
        )
      end

      if client:supports_method("textDocument/documentSymbol") then
        vim.keymap.set(
          "n",
          "<leader>fs",
          ":Pick lsp scope='document_symbol'<CR>",
          vim.tbl_extend("force", opts, { desc = "LSP document symbols" })
        )
      else
        vim.keymap.set(
          "n",
          "<leader>fs",
          unsupported_notify("document symbols"),
          vim.tbl_extend("force", opts, { desc = "LSP document symbols (unsupported)" })
        )
      end

      if client:supports_method("workspace/symbol") then
        vim.keymap.set(
          "n",
          "<leader>fS",
          ":Pick lsp scope='workspace_symbol'<CR>",
          vim.tbl_extend("force", opts, { desc = "LSP workspace symbols" })
        )
      else
        vim.keymap.set(
          "n",
          "<leader>fS",
          unsupported_notify("workspace symbols"),
          vim.tbl_extend("force", opts, { desc = "LSP workspace symbols (unsupported)" })
        )
      end
    end,
  })
end

MiniConfig.sessions = function()
  local minisessions = require("mini.sessions")
  minisessions.setup()

  vim.keymap.set("n", "<leader>ss", function()
    minisessions.select()
  end, { desc = "Select session" })

  vim.keymap.set("n", "<leader>sn", function()
    local cwd = vim.fn.getcwd()
    local root_dir = vim.fn.fnamemodify(cwd, ":t")
    minisessions.write(root_dir)
  end, { desc = "Create session" })

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      local cwd = vim.fn.getcwd()
      local root_dir = vim.fn.fnamemodify(cwd, ":t")

      if minisessions.detected[root_dir] ~= nil and vim.fn.argc() == 0 then
        local choice = vim.fn.confirm(
          string.format("Restore session '%s'?", root_dir),
          "&Yes\n&No",
          1 -- Default to Yes
        )
        if choice == 1 then
          minisessions.read(root_dir)
        end
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
  local minibufremove = require("mini.bufremove")
  minibufremove.setup()
  vim.keymap.set("n", "<leader>bd", minibufremove.delete, { desc = "Delete current buffer" })
  vim.keymap.set("n", "<leader>bc", function()
    local current_buf = vim.api.nvim_get_current_buf()
    local deleted_count = 0
    local skipped_modified = 0

    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      -- Safety checks: skip buffers that shouldn't be deleted
      local should_skip = false

      -- Skip if buffer is not valid
      if not vim.api.nvim_buf_is_valid(bufnr) then
        should_skip = true
      end

      -- Skip current buffer
      if not should_skip and bufnr == current_buf then
        should_skip = true
      end

      -- Skip modified buffers (unsaved changes)
      if not should_skip and vim.bo[bufnr].modified then
        should_skip = true
        skipped_modified = skipped_modified + 1
      end

      -- Skip special buffers (terminal, quickfix, help, etc.)
      if not should_skip and vim.bo[bufnr].buftype ~= "" then
        should_skip = true
      end

      if not should_skip then
        minibufremove.delete(bufnr)
        deleted_count = deleted_count + 1
      end
    end

    -- Notify user of cleanup results
    if skipped_modified > 0 then
      vim.notify(
        string.format("Deleted %d buffers (%d modified skipped)", deleted_count, skipped_modified),
        vim.log.levels.INFO
      )
    else
      vim.notify(string.format("Deleted %d buffers", deleted_count), vim.log.levels.INFO)
    end
  end, { desc = "Cleanup buffers" })
end

return plugin_definition

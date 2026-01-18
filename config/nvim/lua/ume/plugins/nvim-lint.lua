return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")

    local haml_lint_config = {
      cmd = "haml-lint",
      stdin = false,
      append_fname = true,
      parser = require("lint.parser").from_pattern(
        "^.+:(%d+) %[([EWF])%] ([^:]+): (.+)$",
        { "lnum", "severity", "code", "message" },
        {
          ["E"] = vim.diagnostic.severity.ERROR,
          ["W"] = vim.diagnostic.severity.WARN,
        },
        { source = "haml-lint" }
      ),
    }

    lint.linters.haml_lint = haml_lint_config
    lint.linters_by_ft = {
      lua = { "luacheck" },
      ruby = { "ruby", "rubocop" },
      haml = { "haml_lint" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("ume_lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost" }, {
      group = lint_augroup,
      callback = function()
        -- Only lint if a linter is available for this filetype
        local linters = lint.linters_by_ft[vim.bo.filetype]
        if linters and #linters > 0 then
          lint.try_lint()
        end
      end,
    })
  end,
}

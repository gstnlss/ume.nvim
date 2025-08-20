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
      ruby = { "ruby" },
      haml = { "haml_lint" },
      javascript = { "eslint_d" },
    }

    vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}

return {
  {
    'jose-elias-alvarez/null-ls.nvim',
    enabled = false,
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function()
      local nls = require('null-ls')
      return {
        sources = {
          nls.builtins.diagnostics.fish,
          nls.builtins.diagnostics.flake8,
          nls.builtins.diagnostics.selene,
          nls.builtins.diagnostics.shellcheck,
          nls.builtins.formatting.black,
          nls.builtins.formatting.fish_indent,
          nls.builtins.formatting.isort,
          nls.builtins.formatting.prettier,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.stylua,
        },
      }
    end,
  },
  {
    'stevearc/conform.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      formatters_by_ft = {
        bash = { 'shellcheck', 'shfmt' },
        fish = { 'fish_indent' },
        javascript = { 'prettier' },
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        sh = { 'shellcheck', 'shfmt' },
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },
    },
  },
}

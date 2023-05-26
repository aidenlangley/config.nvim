return {
  {
    'jose-elias-alvarez/null-ls.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function()
      local nls = require('null-ls')
      return {
        sources = {
          nls.builtins.diagnostics.fish,
          nls.builtins.diagnostics.flake8,
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
}
return {
  {
    'stevearc/conform.nvim',
    lazy = true,
    dev = false,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      formatters_by_ft = {
        bash = { 'shfmt' },
        fish = { 'fish_indent' },
        go = { 'gofumpt', 'goimports', 'golines' },
        javascript = { 'prettier' },
        lua = { 'stylua' },
        php = { 'php_cs_fixer' },
        python = { 'isort', 'black' },
        sh = { 'shfmt' },
        yaml = { 'prettier' },
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },
      formatters = {
        php_cs_fixer = {
          command = require('utils').path_or(
            { 'vendor/bin/php-cs-fixer' },
            'php-cs-fixer'
          ),
          args = { 'fix', '$FILENAME' },
          stdin = false,
        },
      },
    },
  },
  {
    'mfussenegger/nvim-lint',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    init = function()
      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
    config = function(_, _)
      require('lint').linters_by_ft = {
        bash = { 'shellcheck' },
        go = { 'golangcilint' },
        lua = { 'selene' },
        php = { 'phpstan' },
        python = { 'flake8' },
        sh = { 'shellcheck' },
      }
    end,
  },
}

return {
  {
    'stevearc/conform.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      formatters_by_ft = {
        bash = { 'shfmt' },
        fish = { 'fish_indent' },
        javascript = { 'prettier' },
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        sh = { 'shfmt' },
        yaml = { 'prettier' },
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
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
        lua = { 'selene' },
        python = { 'flake8' },
        sh = { 'shellcheck' },
      }
    end,
  },
}

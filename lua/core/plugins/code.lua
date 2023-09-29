return {
  {
    'stevearc/conform.nvim',
    lazy = true,
    dev = false,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      log_level = vim.log.levels.TRACE,
      formatters_by_ft = {
        bash = { 'shfmt' },
        fish = { 'fish_indent' },
        go = { 'golines' },
        javascript = { 'prettier' },
        lua = { 'stylua' },
        php = { 'php_cs_fixer' },
        python = { 'isort', 'black' },
        sh = { 'shfmt' },
        yaml = { 'prettier_yaml' },
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          vim.notify('Conform: format_on_save disabled', vim.log.levels.INFO)
          return
        end
        return {
          timeout_ms = 500,
          lsp_fallback = true,
        }
      end,
      formatters = {
        prettier_yaml = function()
          local p = require('conform.formatters.prettier')
          return vim.tbl_deep_extend('force', p, {
            args = require('conform.util').extend_args(
              p.args,
              { '--no-bracket-spacing' }
            ),
          })
        end,
      },
    },
    config = function(_, opts)
      require('conform').setup(opts)

      vim.api.nvim_create_user_command('FormatToggle', function(args)
        if args.bang then
          -- FormatToggle! will toggle formatting just for this buffer
          vim.b['disable_autoformat'] = not vim.b.disable_autoformat
        else
          vim.g['disable_autoformat'] = not vim.g.disable_autoformat
        end
      end, {
        desc = 'Conform: Toggle format on save',
        bang = true,
      })
    end,
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

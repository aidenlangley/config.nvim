return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      -- log_level = vim.log.levels.TRACE,
      formatters = {
        prettier_yaml = function()
          return require('nedia.core.formatter').extend(
            require('conform.formatters.prettier'),
            { '--no-bracket-spacing' }
          )
        end,
      },
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
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
    config = function(_, opts)
      require('conform').setup(opts)

      vim.api.nvim_create_user_command('FormatToggle', function(args)
        ---@diagnostic disable-next-line: undefined-field
        local toggle, scope = not vim.b.disable_autoformat, vim.g
        if args.bang then
          -- FormatToggle! will toggle formatting just for this buffer
          scope = vim.b
        end

        local msg = 'Disabled formatting on save'
        if toggle then
          msg = 'Resumed format on save'
        end

        scope['disable_autoformat'] = toggle
        vim.notify(msg, vim.log.levels.INFO)
      end, { desc = 'Toggle format on save', bang = true })
    end,
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function(_, _)
      ---@type table
      require('lint').linters_by_ft = {
        bash = { 'shellcheck' },
        go = { 'golangcilint' },
        lua = { 'selene' },
        php = { 'phpstan' },
        python = { 'flake8' },
        sh = { 'shellcheck' },
      }

      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
  {
    'ahmedkhalf/project.nvim',
    main = 'project_nvim',
    config = true,
  },
  {
    'mcauley-penney/tidy.nvim',
    event = 'BufWrite',
  },
  {
    'https://git.sr.ht/~nedia/auto-save.nvim',
    -- 'aidenlangley/auto-save.nvim',
    dev = false,
    event = 'BufReadPre',
    opts = {
      events = { 'InsertLeave', 'BufLeave' },
      silent = false,
      exclude_ft = { 'neo-tree' },
    },
  },
  {
    'ggandor/flit.nvim',
    dependencies = { 'ggandor/leap.nvim' },
    keys = {
      { 'f', mode = { 'n', 'x', 'o' } },
      { 'F', mode = { 'n', 'x', 'o' } },
    },
    opts = {
      keys = { f = 'f', F = 'F', t = '<Nop>', T = '<Nop>' },
      labeled_modes = 'nxo',
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'windwp/nvim-ts-autotag',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      auto_install = true,
      ensure_installed = {
        'bash',
        'lua',
        'markdown',
        'markdown_inline',
        'regex',
        'vim',
      },
      autotag = { enable = true },
      highlight = { enable = true },
      context_commentstring = { enable = true },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']c'] = '@class.outer',
            [']f'] = '@function.outer',
            [']z'] = {
              query = '@fold',
              query_group = 'folds',
            },
          },
          goto_next_end = {
            [']C'] = '@class.outer',
            [']F'] = '@function.outer',
            [']Z'] = {
              query = '@fold',
              query_group = 'folds',
            },
          },
          goto_previous_start = {
            ['[c'] = '@class.outer',
            ['[f'] = '@function.outer',
            ['[z'] = {
              query = '@fold',
              query_group = 'folds',
            },
          },
          goto_previous_end = {
            ['[C'] = '@class.outer',
            ['[F'] = '@function.outer',
            ['[Z'] = {
              query = '@fold',
              query_group = 'folds',
            },
          },
          goto_next = { [']p'] = '@parameter.outer' },
          goto_previous = { ['[p'] = '@parameter.outer' },
        },
        swap = {
          enable = true,
          swap_next = { ['>p'] = '@parameter.inner' },
          swap_previous = { ['<p'] = '@parameter.inner' },
        },
      },
    },
    config = function(_, opts)
      -- Code folding via treesitter
      vim.o.foldmethod = 'expr'
      vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}

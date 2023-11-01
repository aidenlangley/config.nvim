return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      check_ts = true,
      enable_check_bracket_line = false,
    },
    config = function(_, opts)
      local autopairs = require('nvim-autopairs')
      autopairs.setup(opts)
      autopairs.enable()
    end,
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

      local utils = require('nedia.utils')
      utils.leader('n', 'co', utils.cmd('ConformInfo'), { desc = 'Conform' })
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
        lua = { 'selene', 'luacheck' },
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
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      events = { 'InsertLeave', 'BufLeave' },
      silent = false,
      exclude_ft = { 'neo-tree' },
    },
  },
  {
    'ggandor/leap.nvim',
    config = function(_, _)
      local hl = vim.api.nvim_set_hl
      hl(0, 'LeapBackdrop', { link = '@comment' })
      hl(0, 'LeapMatch', { fg = 'white', bold = true, nocombine = true })

      local colours = require('nedia.colours')
      local red, ora = colours.bright_red, colours.bright_orange
      hl(0, 'LeapLabelPrimary', { fg = red, bold = true, nocombine = true })
      hl(0, 'LeapLabelSecondary', { fg = ora, bold = true, nocombine = true })
    end,
  },
  {
    'ggandor/flit.nvim',
    dependencies = {
      'ggandor/leap.nvim',
      'tpope/vim-repeat',
    },
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
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'windwp/nvim-ts-autotag',
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
  {
    'monaqa/dial.nvim',
    keys = {
      { '<C-a>', mode = { 'n', 'v' } },
      { '<C-x>', mode = { 'n', 'v' } },
    },
    config = function()
      local augend = require('dial.augend')
      require('dial.config').augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias['%Y/%m/%d'],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
        },
      })

      local utils = require('nedia.utils')
      local keymap = utils.keymap
      local dial = require('dial.map')

      keymap('n', '<C-a>', dial.inc_normal(), { desc = 'Increment value' })
      keymap('n', '<C-x>', dial.dec_normal(), { desc = 'Decrement value' })
      keymap('v', '<C-a>', dial.inc_visual(), { desc = 'Increment value' })
      keymap('v', '<C-x>', dial.dec_visual(), { desc = 'Decrement value' })
    end,
  },
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    event = 'BufReadPost',
    opts = {
      prompt_func_return_type = {
        go = true,
      },
      prompt_func_param_type = {
        go = true,
      },
    },
    config = function(_, opts)
      require('refactoring').setup(opts)

      local utils = require('nedia.utils')
      local leader = utils.leader

      leader({ 'n', 'x' }, 'rr', function()
        require('refactoring').select_refactor({})
      end, { desc = 'Refactor' })
      leader('x', 'ref', function()
        require('refactoring').refactor('Extract Function')
      end, { desc = 'Extract func' })
      leader('x', 'rev', function()
        require('refactoring').refactor('Extract Variable')
      end, { desc = 'Extract var' })
      leader('n', 'rif', function()
        require('refactoring').refactor('Inline Function')
      end, { desc = 'Inline func' })
      leader({ 'n', 'x' }, 'riv', function()
        require('refactoring').refactor('Inline Variable')
      end, { desc = 'Inline var' })
      leader('n', 'rbb', function()
        require('refactoring').refactor('Extract Block')
      end, { desc = 'Extract block' })
      leader('n', 'rbf', function()
        require('refactoring').refactor('Extract Block To File')
      end, { desc = 'Extract block to file' })

      leader('n', 'rp', function()
        require('refactoring').debug.printf({ below = false })
      end, { desc = 'Insert printf' })
      leader({ 'x', 'n' }, 'rv', function()
        require('refactoring').debug.print_var({})
      end, { desc = 'Print var' })
      leader('n', 'rc', function()
        require('refactoring').debug.cleanup({})
      end, { desc = 'Clean up' })
    end,
  },
}

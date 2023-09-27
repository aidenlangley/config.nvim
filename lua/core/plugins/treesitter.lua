return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'windwp/nvim-ts-autotag',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    build = ':TSUpdate',
    lazy = true,
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
      highlight = {
        enable = true,
        -- disable = { 'dart' },
      },
      context_commentstring = { enable = true },
      textobjects = {
        move = {
          enable = true,
          set_jumps = false,
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
          goto_next = {
            [']g'] = '@call.outer',
            [']p'] = '@parameter.outer',
          },
          goto_previous = {
            ['[g'] = '@call.outer',
            ['[p'] = '@parameter.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['>p'] = '@parameter.inner',
          },
          swap_previous = {
            ['<p'] = '@parameter.inner',
          },
        },
      },
    },
    config = function(_, opts)
      -- Code folding via treesitter
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'windwp/nvim-ts-autotag',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    build = ':TSUpdate<CR>',
    lazy = true,
    event = 'BufReadPre',
    opts = {
      auto_install = true,
      autotag = { enable = true },
      highlight = { enable = true },
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
              desc = 'Next fold start',
            },
          },
          goto_next_end = {
            [']C'] = '@class.outer',
            [']F'] = '@function.outer',
            [']Z'] = {
              query = '@fold',
              query_group = 'folds',
              desc = 'Next fold end',
            },
          },
          goto_previous_start = {
            ['[c'] = '@class.outer',
            ['[f'] = '@function.outer',
            ['[z'] = {
              query = '@fold',
              query_group = 'folds',
              desc = 'Next fold start',
            },
          },
          goto_previous_end = {
            ['[C'] = '@class.outer',
            ['[F'] = '@function.outer',
            ['[Z'] = {
              query = '@fold',
              query_group = 'folds',
              desc = 'Next fold end',
            },
          },
          goto_next = {
            [']g'] = '@call.outer',
            [']p'] = '@paramater.outer',
          },
          goto_previous = {
            ['[g'] = '@call.outer',
            ['[p'] = '@paramater.outer',
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
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
return {
  {
    'folke/which-key.nvim',
    enabled = true,
    lazy = true,
    keys = {
      '<Leader>',
      '[',
      ']',
      'b',
      'g',
      't',
      'w',
      'z',
    },
    opts = {
      plugins = {
        marks = false,
        presets = {
          g = true,
          nav = false,
          operators = false,
          text_objects = false,
          windows = false,
          z = true,
        },
        registers = false,
        spelling = true,
      },
      defaults = {},
      disable = {
        filetypes = {
          'neo-tree',
          'TelescopePrompt',
        },
      },
      key_labels = {
        ['<leader>'] = 'SPC',
        ['<Leader>'] = 'SPC',
        ['<space>'] = 'SPC',
        ['<Space>'] = 'SPC',
      },
      show_help = false,
      show_keys = true,
    },
  },
}

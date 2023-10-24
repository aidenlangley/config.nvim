return {
  {
    'folke/which-key.nvim',
    enabled = true,
    lazy = true,
    event = 'VeryLazy',
    opts = {
      key_labels = {
        ['<leader>'] = 'SPC',
        ['<Leader>'] = 'SPC',
        ['<space>'] = 'SPC',
        ['<Space>'] = 'SPC',
      },
      window = { border = 'single' },
      show_help = true,
      show_keys = true,
      disable = {
        filetypes = {
          'neo-tree',
          'TelescopePrompt',
        },
      },
    },
  },
}

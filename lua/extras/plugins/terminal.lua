return {
  {
    'akinsho/toggleterm.nvim',
    lazy = true,
    keys = { '<C-\\>' },
    opts = {
      open_mapping = '<C-\\>',
      direction = 'float',
      shell = '/usr/bin/fish',
    },
  },
}
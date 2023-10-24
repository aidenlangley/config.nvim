return {
  {
    'petertriho/nvim-scrollbar',
    dependencies = { 'lewis6991/gitsigns.nvim' },
    lazy = true,
    event = 'BufAdd',
    opts = {
      excluded_filetypes = {
        'TelescopePrompt',
        'cmp_docs',
        'cmp_menu',
        'neo-tree',
        'noice',
        'notify',
        'prompt',
      },
      handlers = { gitsigns = true },
    },
  },
  {
    'anuvyklack/windows.nvim',
    dependencies = { 'anuvyklack/middleclass' },
    lazy = true,
    event = 'BufAdd',
    config = true,
  },
}

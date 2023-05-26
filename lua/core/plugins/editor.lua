return {
  {
    'windwp/nvim-autopairs',
    lazy = true,
    event = 'InsertEnter',
    config = true,
  },
  {
    'mcauley-penney/tidy.nvim',
    lazy = true,
    event = 'BufWrite',
  },
  {
    'https://git.sr.ht/~nedia/auto-save.nvim',
    event = 'BufReadPre',
    opts = {
      events = { 'InsertLeave', 'BufLeave' },
      silent = false,
      exclude_ft = { 'neo-tree' },
    },
  },
  {
    'https://git.sr.ht/~nedia/auto-format.nvim',
    event = 'InsertLeavePre',
    config = true,
  },
}
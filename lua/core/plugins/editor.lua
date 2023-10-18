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
    'https://git.sr.ht/~nedia/auto-format.nvim',
    -- 'aidenlangley/auto-format.nvim',
    enabled = false,
    dev = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },
}

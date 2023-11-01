return {
  {
    'tpope/vim-sensible',
    event = 'VeryLazy',
  },
  {
    'tpope/vim-sleuth',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'tpope/vim-fugitive',
    cmd = { 'G', 'Git' },
  },
  {
    'tpope/vim-surround',
    enabled = false,
    dependencies = { 'tpope/vim-repeat' },
    keys = { 'cs', 'ds', 'ys' },
  },
}

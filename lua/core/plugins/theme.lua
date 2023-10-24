return {
  {
    'ellisonleao/gruvbox.nvim',
    enabled = true,
    lazy = false,
    priority = 1000,
    opts = {
      italic = {
        strings = false,
        comments = false,
        operators = false,
        folds = false,
      },
      contrast = 'hard',
      transparent_mode = true,
    },
    config = function(_, opts)
      require('gruvbox').setup(opts)
      vim.cmd('colorscheme gruvbox')
    end,
  },
}

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
  {
    'projekt0n/github-nvim-theme',
    enabled = false,
    priority = 1000,
    config = function()
      require('github-theme').setup({ options = { transparent = false } })
      vim.cmd('colorscheme github_dark_dimmed')
    end,
  },
  {
    'Mofiqul/adwaita.nvim',
    enabled = false,
    priority = 1000,
    config = function()
      vim.g.adwaita_transparent = true
      vim.cmd('colorscheme adwaita')
    end,
  },
}
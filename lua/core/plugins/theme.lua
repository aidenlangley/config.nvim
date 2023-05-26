return {
  {
    'morhetz/gruvbox',
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = 'dark'
      vim.g.gruvbox_transparent_bg = '1'
      vim.g.gruvbox_contrast_dark = 'hard'
      vim.g.gruvbox_invert_selection = '0'
      vim.g.gruvbox_sign_column = 'bg0'
      vim.cmd('colorscheme gruvbox')
    end,
  },
  {
    'projekt0n/github-nvim-theme',
    enabled = false,
    priority = 1000,
    config = function()
      require('github-theme').setup({
        options = {
          transparent = false,
        },
      })
      vim.cmd('colorscheme github_dark_high_contrast')
    end,
  },
  {
    'Mofiqul/adwaita.nvim',
    enabled = false,
    priority = 1000,
    config = function()
      vim.g.adwaita_darker = false
      vim.g.adwaita_disable_cursorline = true
      vim.g.adwaita_transparent = true
      vim.cmd('colorscheme adwaita')
    end,
  },
}
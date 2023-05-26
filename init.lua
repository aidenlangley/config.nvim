-- Starts dashboard when Lazy has started.
vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyVimStarted',
  once = true,
  callback = function()
    -- Checks that a file wasn't passed as an argument to nvim
    if vim.fn.argc() == 0 or vim.fn.argv() == 0 then
      require('mini.starter').open(vim.api.nvim_get_current_buf())
    end
  end,
})

-- Set our leader keys prior to any keymaps.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Use terminal colours before plugins also.
vim.opt.termguicolors = true

-- Bootstrap lazy - if it's not installed, install it.
local lazy = require('core.lazy')
lazy.bootstrap()

-- Setup lazy & our core plugins
require('lazy').setup({
  { import = 'core.plugins.dashboard' },
  { import = 'core.plugins.cmp' },
  { import = 'core.plugins.code' },
  { import = 'core.plugins.editor' },
  { import = 'core.plugins.lsp' },
  { import = 'core.plugins.mini' },
  { import = 'core.plugins.movement' },
  { import = 'core.plugins.theme' },
  { import = 'core.plugins.treesitter' },
  { import = 'core.plugins.ui' },
  { import = 'core.plugins.vim' },
  { import = 'extras.plugins.code' },
  { import = 'extras.plugins.editor' },
  { import = 'extras.plugins.explorer' },
  { import = 'extras.plugins.git' },
  { import = 'extras.plugins.status_bar' },
  { import = 'extras.plugins.telescope' },
  { import = 'extras.plugins.terminal' },
  { import = 'extras.plugins.ui' },
  { import = 'extras.plugins.which_key' },
  { import = 'lsp.flutter' },
  { import = 'lsp.lua' },
}, lazy.opts)

-- Configure vim.
require('core.options')
require('core.keymaps')
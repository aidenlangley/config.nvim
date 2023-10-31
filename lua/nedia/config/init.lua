require('nedia.config.settings')
require('nedia.config.keymaps')

-- Gets lazy options, and bootstraps lazy
local opts = require('nedia.lazy')

-- Put together our spec, structlog first
local spec = {
  'Tastyep/structlog.nvim',
  { import = 'nedia.lazy.plugins' },
}

-- Fire away
require('lazy').setup(spec, opts)

-- Set colorscheme last
vim.cmd([[colorscheme gruvbox]])

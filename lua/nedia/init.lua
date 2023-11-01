-- Immediately handle settings
require('nedia.config.settings')

-- Gets lazy options, and bootstraps lazy
local opts = require('nedia.lazy')

-- Put together our spec, structlog first
local spec = {
  'Tastyep/structlog.nvim',
  { import = 'nedia.lazy.plugins' },
}

-- Fire away
require('lazy').setup(spec, opts)

-- Configure our last bits
require('nedia.config.keymaps')
require('nedia.config.auto_cmds')
require('nedia.config.cmds')

-- Finally set colourscheme
vim.cmd([[colorscheme gruvbox]])

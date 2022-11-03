-- Runs packer:
-- Installs it first, if not already installs.
-- Initialises with options.
-- Registers plugins then syncs.
require("plugins.packer")

-- Configure plugins:
require("plugins.config.completions")
require("plugins.config.dap")
require("plugins.config.explorer")
require("plugins.config.lsp")
require("plugins.config.statusline")
require("plugins.config.telescope")
require("plugins.config.treesitter")

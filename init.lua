-- NOTE: Must happen before plugins are required, otherwise wrong leader will
-- be used
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Handle plugins, return bootstrap status
local is_bootstrap = require("bootstrap")

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
	vim.notify("Plugins installing. Once Packer is finished, restart nvim.", vim.log.levels.INFO)
	return
end

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default, and have them relative to current line
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Right mouse extends selection
vim.o.mousemodel = "extend"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time & timeout length
vim.o.updatetime = 250
vim.o.timeoutlen = 500

-- Add diagnostic symbols to left-hand column
vim.wo.signcolumn = "yes"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Highlight current line
vim.o.cursorline = true

-- Split logically - not before the current window, but afterwards
vim.o.splitbelow = true
vim.o.splitright = true

-- Disable line wrapping
vim.o.wrap = false

-- Moving to the end of the line will wrap the cursor
vim.opt.whichwrap:append("<,>,[,],h,l")

-- Completion menu height
vim.o.pumheight = 16

-- Add a ruler at 80 & 100 lines
vim.o.colorcolumn = "80,100"

-- Share clipboard with system
vim.o.clipboard = "unnamedplus"

-- Indenting, doesn't impact the file itself, just displays 2 spaces for a tab
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.tabstop = 2

-- Enable lazy loading filetype specific code
vim.opt.filetype.plugin = "true"

-- Use terminal colours
vim.o.termguicolors = true

-- Status line shows mode so we can stop showing the tradition mode
vim.o.showmode = false

-- Title string
vim.o.title = true
vim.o.titlestring = "%<%F%="

-- Plugins, LSP, important UI components, etc.
require("core")

-- Superfluous plugins or configuration.
require("extra")

-- Set colorscheme
vim.o.background = "dark"
vim.g.gruvbox_material_background = "hard"
vim.cmd([[colorscheme gruvbox-material]])

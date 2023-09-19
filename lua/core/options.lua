-- Set our leader keys prior to any keymaps.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Backups please
vim.opt.backup = true
vim.opt.backupdir = vim.fn.stdpath('state') .. '/backups'

-- Set highlight on search
vim.opt.hlsearch = false

-- Make line numbers default, and have them relative to current line
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time & timeout length
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500

-- Add diagnostic symbols to left-hand column
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience - basically the least
-- intrusive it can be.
--
-- 'menuone' displays a menu, even when there is only one option
-- 'noinsert' will prevent the command prompt from being populated with the
-- completion option until selected.
-- 'noselect' ensures the user selects the item from the menu manually.
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }

-- Highlight current line
vim.opt.cursorline = false

-- Split logically - not before the current window, but afterwards
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Disable line wrapping
vim.opt.wrap = false

-- Moving to the end of the line will wrap the cursor
vim.opt.whichwrap:append('<,>,[,],h,l')

-- Completion menu height
vim.opt.pumheight = 16
vim.opt.pumwidth = 8

-- Add a ruler at 80 & 100 lines
vim.opt.colorcolumn = '80,100'

-- Share clipboard with system
vim.opt.clipboard = 'unnamedplus'

-- Indenting, doesn't impact the file itself, just displays 2 spaces for a tab
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2

-- Writes buffer on :next, :rewind, etc.
vim.opt.autowrite = true

-- Use ripgrep w/ --vimgrep arg.
vim.opt.grepprg = 'rg --vimgrep'

-- Status line shows mode so we can stop showing the tradition mode
vim.opt.showmode = false

-- Lines to keep above/below & left/right of cursor
vim.opt.scrolloff = 0
vim.opt.sidescrolloff = 0

-- Code folding
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = '-',
}

-- Command mode completion
vim.opt.wildmode = 'longest:full,full'

-- Sessions
vim.opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }

-- Floating status lines, works well with `incline.nvim`
vim.opt.laststatus = 3

-- Treat dash separated words as a word text object
vim.opt.iskeyword:append('-')

-- Title string
vim.opt.title = true
vim.opt.titlestring = 'nvim: %<%F'

-- Disable status bar until later
vim.opt.laststatus = 0
vim.opt.statusline = ''

-- nvim 9+
if vim.fn.has('nvim-0.9.0') == 1 then
  vim.opt.splitkeep = 'screen'
  vim.opt.shortmess:append({ C = true })
end

-- Make all keymaps silent by default
local keymap_set = vim.keymap.set
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.desc = opts.desc or string.format('%s -> $s', lhs, rhs)
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
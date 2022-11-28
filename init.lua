local set = vim.opt
local opt = vim.o
local win = vim.wo
local global = vim.g

vim.cmd([[let mapleader=" "]]) -- Set leader key to <Space>
vim.cmd([[set nocompatible]]) -- Disable vi compatibility, this isn't the 70's

-- General:
set.conceallevel = 0 -- Shows  in markdown
set.cursorline = true -- Highlight the line that the cursor is currently on
set.fileencoding = "UTF-8"
set.filetype.plugin = "true"
set.hidden = true -- Keeps multiple buffers open
set.mouse = "a" -- Enable the mouse
set.pumheight = 16 -- Pop up menu height
set.shell = "/usr/bin/sh"
set.showmode = false -- Hide default mode indicator
set.spell = false -- Spell check
set.spelllang = { "en_us", "en_gb", "en_nz" } -- Spell check
set.splitbelow = true
set.splitright = true
set.termguicolors = true
set.timeoutlen = 350
set.title = true
set.titlestring = "%<%F%="
set.updatetime = 0
set.whichwrap:append("<,>,[,],h,l") -- Moving to the end of the line will move to the next line
set.wrap = false -- Don't wrap lines longer than the window width
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Line numbers/ruler:
set.colorcolumn = "80,100"
set.number = true
set.relativenumber = true
set.scrolloff = 4
set.showtabline = 1
set.sidescrolloff = 8
set.signcolumn = "auto"

-- Indenting:
set.autoindent = true
set.expandtab = true
set.shiftwidth = 2
set.smartindent = true
set.tabstop = 2

-- Backups:
set.backup = true
set.backupdir = vim.fn.stdpath("cache") .. "/backup"
set.swapfile = false
set.undodir = vim.fn.stdpath("cache") .. "/undo"
set.undofile = true

-- Clipboard:
set.clipboard = "unnamedplus"

-- Folding:
set.foldexpr = "nvim_treesitter#foldexpr()"
set.foldmethod = "expr"
win.foldenable = true
win.foldlevel = 99

-- UI:
set.cmdheight = 1

-- Completion:
vim.cmd([[set complete+=kspell]])
vim.cmd([[set completeopt=menuone,longest]])

-- Search:
set.hlsearch = false
set.ignorecase = true
set.smartcase = true
vim.cmd([[set path+=**]])

-- Theme:
global.gruvbox_material_background = "hard"
set.background = "dark"
vim.cmd([[colorscheme gruvbox-material]])

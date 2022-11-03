vim.cmd([[filetype plugin on]])
vim.cmd([[let mapleader=" "]])
vim.opt.autoindent = true
vim.opt.background = "dark"
vim.opt.backup = true
vim.opt.backupdir = vim.fn.stdpath("cache") .. "/backup"
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "80"
vim.opt.conceallevel = 0
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.fileencoding = "UTF-8"
vim.opt.filetype.plugin = "true"
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.pumheight = 8
vim.opt.relativenumber = true
vim.opt.scrolloff = 2
vim.opt.shell = "/usr/bin/zsh"
vim.opt.shiftwidth = 2
vim.opt.showmode = false
vim.opt.showtabline = 2
vim.opt.sidescrolloff = 4
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.spell = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = 250
vim.opt.title = true
vim.opt.titlestring = "%<%F%="
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.opt.undofile = true
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.wrap = false
vim.opt.writebackup = false

require("plugins")
require("keymaps")
require("autocmds")

vim.g.gruvbox_material_background = "hard"
vim.cmd([[colorscheme gruvbox-material]])

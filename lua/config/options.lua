vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Backups please
vim.o.backup = true
vim.o.backupdir = vim.fn.stdpath("cache") .. "/backups"

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

-- Set completeopt to have a better completion experience - basically the least
-- intrusive it can be.
--
-- 'menuone' displays a menu, even when there is only one option
-- 'noinsert' will prevent the command prompt from being populated with the
-- completion option until selected.
-- 'noselect' ensures the user selects the item from the menu manually.
vim.o.completeopt = "menuone,noinsert,noselect"

-- Highlight current line
vim.o.cursorline = false

-- Split logically - not before the current window, but afterwards
vim.o.splitbelow = true
vim.o.splitright = true

-- Disable line wrapping
vim.o.wrap = false

-- Moving to the end of the line will wrap the cursor
vim.opt.whichwrap:append("<,>,[,],h,l")

-- Completion menu height
vim.o.pumheight = 16
vim.o.pumwidth = 8

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

-- Use terminal colours
vim.o.termguicolors = true

-- Status line shows mode so we can stop showing the tradition mode
vim.o.showmode = false

-- Lines to keep above/below & left/right of cursor
vim.o.scrolloff = 8
vim.o.sidescrolloff = 4

-- Code folding via treesitter
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.nofoldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.opt.fillchars = { eob = "-", fold = " " }

-- Command mode completion
vim.o.wildmode = "longest:full,full"

-- Sessions
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }

-- Spelling
vim.o.spell = true
vim.o.spelllang = "uk,en"
vim.o.spelloptions = "camel"
vim.opt.complete:append("kspell")

-- Floating status lines, works well with `incline.nvim`
vim.o.laststatus = 3

-- Treat dash separated words as a word text object
vim.opt.iskeyword:append("-")

-- NeoVim 9+
if vim.fn.has("nvim-0.9.0") == 1 then
  vim.o.splitkeep = "screen"
  vim.opt.shortmess:append({ C = true })
end

-- Title string
vim.o.title = true
vim.o.titlestring = "nvim: %<%F%="

-- Don't load the plugins below
local builtins = {
  "gzip",
  "zip",
  "zipPlugin",
  "fzf",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "matchit",
  "matchparen",
  "logiPat",
  "rrhelper",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
}

for _, plugin in ipairs(builtins) do
  vim.g["loaded_" .. plugin] = 1
end

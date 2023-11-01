--stylua: ignore start

-- Leader =====================================================================
vim.g.mapleader = ' '

-- General ====================================================================
vim.o.mouse       = 'a'            -- Enable mouse
vim.o.updatetime  = 250            -- Update faster
vim.o.timeoutlen  = 500            -- Time out sooner
vim.o.backup      = false          -- No backups
vim.o.writebackup = false
vim.o.undofile    = true           -- Persistent undo
vim.o.clipboard   = 'unnamedplus'  -- Share clipboard with system
vim.o.autowrite   = true           -- Writes buffer on :next, :rewind, etc
vim.o.grepprg     = 'rg --vimgrep' -- ripgrep baby

-- Command mode completion
-- vim.o.wildmode = 'longest:full,full'

-- Enable all filetype plugins
vim.cmd([[filetype plugin indent on]])

-- UI =========================================================================
vim.o.breakindent     = true     -- Indent wrapped lines to match line start
vim.o.wrap            = false    -- Don't wrap lines
vim.o.cursorline      = true     -- Highlight current line
vim.o.splitbelow      = true     -- When splitting, new windows go below
vim.o.splitright      = true     -- When splitting, new windows go right
vim.o.pumheight       = 16       -- Increase popup menu height
vim.o.colorcolumn     = '80,100' -- Display a rule at 80 & 100 characters
vim.o.showmode        = false    -- Status line shows mode so hide traditional
vim.o.showtabline     = 2        -- Always show tabline
vim.o.hlsearch        = false    -- Don't highlight search 24/7
vim.wo.number         = true     -- Enable line numbers
vim.wo.relativenumber = true     -- Line numbers relative to current line
vim.wo.signcolumn     = 'yes'    -- Always show sign column

-- Custom title
vim.o.title = true
vim.o.titlestring = 'nvim: %<%F'

-- Disable status bar until later
vim.o.laststatus = 0
vim.o.statusline = ''

if vim.fn.has('nvim-0.9') == 1 then
  vim.opt.shortmess:append('C')  -- Don't show "Scanning..." messages
  vim.o.splitkeep = 'screen'     -- Reduce scroll during window split
end

if vim.fn.has("nvim-0.10") == 1 then
  vim.o.smoothscroll = true
end

-- Colors =====================================================================
vim.o.termguicolors = true

-- Enable syntax highlighing if it wasn't already (as it is time consuming)
-- Don't use defer it because it affects start screen appearance
if vim.fn.exists("syntax_on") ~= 1 then
  vim.cmd([[syntax enable]])
end

-- Editing ====================================================================
vim.o.autoindent  = true
vim.o.expandtab   = true
vim.o.shiftwidth  = 2
vim.o.smartindent = true
vim.o.tabstop     = 2
vim.o.ignorecase  = true  -- Ignore case in search
vim.o.smartcase   = true  -- Match case if a capital is present when searching
vim.o.incsearch   = true -- Show search results while typing

-- Set completeopt to have a better completion experience - basically the least
-- intrusive it can be.
-- * menuone displays a menu, even when there is only one option
-- * noinsert will prevent the command prompt from being populated with the
--   completion option until selected.
-- * noselect ensures the user selects the item from the menu manually.
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }

-- Moving to the end of the line will wrap the cursor
vim.opt.whichwrap:append('<,>,[,],h,l')

-- Treat dash separated words as a word text object
vim.opt.iskeyword:append('-')

-- Fix markdown indentation settings
-- vim.g.markdown_recommended_style = 0

-- Folds ======================================================================
vim.o.foldenable = false
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = '-',
}

-- Spelling ===================================================================
vim.o.spell = true
vim.o.spelllang = 'uk,en'
vim.o.spelloptions = 'camel'
vim.opt.complete:append('kspell')

--stylua: ignore end

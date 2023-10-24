-- Better up/down
vim.keymap.set(
  'n',
  'j',
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true }
)
vim.keymap.set(
  'n',
  'k',
  "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true }
)

-- Buffers
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Write buffer' })
vim.keymap.set('n', 'bw', ':wa<CR>', { desc = 'Write all buffers' })

-- Use mini.bufremove to delete buffers
vim.keymap.set('n', 'bd', function()
  require('mini.bufremove').delete(0, false)
end, { desc = 'Delete buffer', noremap = true })

-- Delete other buffers
vim.keymap.set('n', 'bD', ':%bd|e#|bd#<CR>', { desc = 'Delete other buffers' })

-- Move through buffers
vim.keymap.set(
  'n',
  '}',
  ':bn<CR>',
  { desc = 'Goto next buffer', silent = true }
)
vim.keymap.set(
  'n',
  '{',
  ':bp<CR>',
  { desc = 'Goto prev buffer', silent = true }
)
vim.keymap.set(
  'n',
  '<S-l>',
  ':bn<CR>',
  { desc = 'Goto next buffer', silent = true }
)
vim.keymap.set(
  'n',
  '<S-h>',
  ':bp<CR>',
  { desc = 'Goto prev buffer', silent = true }
)

-- Quit if not modified, else request confirmation
vim.keymap.set('n', '<C-q>', function(bufnr)
  local prompt = 'You have unsaved changes. Quit anyway? (y/N) '
  local callback = function(input)
    if input == 'y' then
      vim.cmd('q!')
    end
  end

  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, 'modified')

  if modified then
    vim.ui.input({ prompt = prompt }, callback)
  else
    vim.cmd('q!')
  end
end, { desc = 'Quit' })

-- Windows
vim.keymap.set(
  'n',
  '<C-h>',
  ':wincmd h<CR>',
  { desc = ' window', silent = true }
)
vim.keymap.set(
  'n',
  '<C-j>',
  ':wincmd j<CR>',
  { desc = ' window', silent = true }
)
vim.keymap.set(
  'n',
  '<C-k>',
  ':wincmd k<CR>',
  { desc = ' window', silent = true }
)
vim.keymap.set(
  'n',
  '<C-l>',
  ':wincmd l<CR>',
  { desc = ' window', silent = true }
)

-- Move lines
local move_lines_desc = 'Move line down'
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = move_lines_desc })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = move_lines_desc })
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { desc = move_lines_desc })

move_lines_desc = 'Move line up'
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = move_lines_desc })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = move_lines_desc })
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { desc = move_lines_desc })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set(
  'n',
  'n',
  "'Nn'[v:searchforward]",
  { desc = 'Search forwards', expr = true }
)
vim.keymap.set(
  'x',
  'n',
  "'Nn'[v:searchforward]",
  { desc = 'Search forwards', expr = true }
)
vim.keymap.set(
  'o',
  'n',
  "'Nn'[v:searchforward]",
  { desc = 'Search forwards', expr = true }
)
vim.keymap.set(
  'n',
  'N',
  "'nN'[v:searchforward]",
  { desc = 'Search backwards', expr = true }
)
vim.keymap.set(
  'x',
  'N',
  "'nN'[v:searchforward]",
  { desc = 'Search backwards', expr = true }
)
vim.keymap.set(
  'o',
  'N',
  "'nN'[v:searchforward]",
  { desc = 'Search backwards', expr = true }
)

-- Code actions & formatting can function without a language server
vim.keymap.set('n', '<C-.>', vim.lsp.buf.code_action, { desc = 'Code actions' })

-- Diagnostics
vim.keymap.set(
  'n',
  ']d',
  vim.diagnostic.goto_next,
  { desc = 'Goto next diagnostic' }
)
vim.keymap.set(
  'n',
  '[d',
  vim.diagnostic.goto_prev,
  { desc = 'Goto prev diagnostic' }
)

-- Open the dashboard
vim.keymap.set('n', '<Leader>da', function()
  require('mini.starter').open()
end, { desc = 'Open dashboard' })

-- Lazy
vim.keymap.set('n', '<Leader>la', ':Lazy<CR>', { desc = 'Open Lazy' })
vim.keymap.set('n', '<Leader>sy', ':Lazy sync<CR>', { desc = 'Sync plugins' })
vim.keymap.set(
  'n',
  '<Leader>up',
  ':Lazy update<CR>',
  { desc = 'Update plugins' }
)

-- Mason
vim.keymap.set('n', '<Leader>ma', ':Mason<CR>', { desc = 'Open Mason' })

-- Open settings
vim.keymap.set(
  'n',
  '<Leader>se',
  ':e ~/.config/nvim/init.lua<CR>',
  { desc = 'Settings' }
)

-- Open a lazygit terminal
vim.keymap.set('n', '<Leader>gg', function()
  require('utils').float_term('lazygit'):toggle()
end, { desc = 'Open LazyGit' })

-- Navigate tabs
vim.keymap.set('n', ']t', ':tabnext<CR>', { desc = 'Goto next tab' })
vim.keymap.set('n', '[t', ':tabprevious<CR>', { desc = 'Goto prev tab' })

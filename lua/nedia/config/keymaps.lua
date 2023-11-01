local Utils = require('nedia.utils')
local cmd = Utils.cmd
local float_term = Utils.float_term
local keymap = Utils.keymap
local leader = Utils.leader

keymap('n', '<C-s>', cmd('w'), { desc = 'Write buffer' })
keymap('n', 'bw', cmd('wa'), { desc = 'Write all buffers' })
keymap('n', 'bd', Utils.safe_delete, { desc = 'Delete buffer' })
keymap('n', 'bD', cmd('bd!'), { desc = 'Delete buffer (force)' })
keymap('n', { '}', '<S-l>' }, cmd('bn'), { desc = 'Goto next buffer' })
keymap('n', { '{', '<S-h>' }, cmd('bp'), { desc = 'Goto prev buffer' })
keymap('n', '<C-h>', cmd('wincmd h'), { desc = ' window' })
keymap('n', '<C-j>', cmd('wincmd j'), { desc = ' window' })
keymap('n', '<C-k>', cmd('wincmd k'), { desc = ' window' })
keymap('n', '<C-l>', cmd('wincmd l'), { desc = ' window' })
keymap('n', '<C-q>', Utils.smart_quit, { desc = 'Quit' })
keymap('n', '<C-.>', vim.lsp.buf.code_action, { desc = 'Code actions' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Goto next diagnostic' })
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Goto prev diagnostic' })
leader('n', 'se', cmd('e ~/.config/nvim/init.lua'), { desc = 'Settings' })
leader('n', 'gc', cmd('e .git/config'), { desc = 'Git config' })
leader('n', 'log', cmd('e $NVIM_LOG_FILE'), { desc = 'Neovim log' })
leader('n', 'slo', cmd('e ~/.config/nvim/log.txt'), { desc = 'Structured log' })

-- Smarter up & down
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })

local desc = 'Move line down'
keymap('n', '<A-j>', ':m .+1<CR>==', { desc = desc })
keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = desc })
keymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { desc = desc })

desc = 'Move line up'
keymap('n', '<A-k>', ':m .-2<CR>==', { desc = desc })
keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = desc })
keymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { desc = desc })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
local modes = { 'n', 'x', 'o' }
keymap(modes, 'n', "'Nn'[v:searchforward]", { expr = true })
keymap(modes, 'N', "'nN'[v:searchforward]", { expr = true })

leader('n', 'gg', function()
  float_term('lazygit'):toggle()
end, { desc = 'LazyGit' })

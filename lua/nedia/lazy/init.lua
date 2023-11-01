local path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local url = 'https://github.com/folke/lazy.nvim.git'
local branch = 'stable'

if not vim.loop.fs_stat(path) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    url,
    '--branch=' .. branch,
    path,
  })
end

vim.opt.rtp:prepend(path)

-- Starts dashboard when Lazy has started.
vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyVimStarted',
  once = true,
  callback = function()
    ---@type boolean, table
    local ok, ms = pcall(require, 'mini.starter')
    if ok then
      -- Checks that a file wasn't passed as an argument to nvim
      if vim.fn.argc() == 0 or vim.fn.argv() == 0 then
        ms.open(vim.api.nvim_get_current_buf())
      end
    end
  end,
})

local utils = require('nedia.utils')
utils.leader('n', 'la', utils.cmd('Lazy'), { desc = 'Lazy' })

return require('nedia.lazy.options')

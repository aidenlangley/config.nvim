vim.api.nvim_create_user_command(
  'DeleteOtherBuf',
  require('nedia.utils').cmd(':%bd|e#|bd#<CR>'),
  { desc = 'Delete other buffers' }
)

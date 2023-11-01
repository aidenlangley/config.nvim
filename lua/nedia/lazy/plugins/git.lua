return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local keymaps = {
        { 'n', 'gb', 'blame_line', { desc = 'Blame line' } },
        { 'n', 'gB', 'toggle_current_line_blame', { desc = 'Toggled blame' } },
        { 'n', 'gd', 'toggle_deleted', { desc = 'Toggled deleted' } },
        { 'n', 'gD', 'diffthis', { desc = 'Show diff' } },
        { 'n', 'gp', 'preview_hunk', { desc = 'Preview hunk' } },
        { 'n', 'gS', 'stage_buffer', { desc = 'Stage buffer' } },
        { 'n', 'gR', 'reset_buffer', { desc = 'Reset buffer' } },
        { { 'n', 'v' }, 'gr', 'reset_hunk', { desc = 'Reset hunk' } },
      }

      local utils = require('nedia.utils')
      local keymap, leader, cmd = utils.keymap, utils.leader, utils.cmd
      for _, key in ipairs(keymaps) do
        leader(key[1], key[2], cmd('Gitsigns ' .. key[3]), key[4])
      end

      keymaps = {
        {
          'n',
          ']g',
          "&diff ? ']g' : 'next_hunk'",
          { expr = true, desc = 'Goto next hunk' },
        },
        {
          'n',
          '[g',
          "&diff ? '[g' : 'prev_hunk'",
          { expr = true, desc = 'Goto prev hunk' },
        },
        {
          { 'n', 'v' },
          '<Leader>gs',
          ":execute 'Gitsigns stage_hunk' | Gitsigns next_hunk",
          { desc = 'Stage hunk' },
        },
        {
          { 'n', 'v' },
          '<Leader>gu',
          ":execute 'Gitsigns undo_stage_hunk' | Gitsigns prev_hunk",
          { desc = 'Undo stage hunk' },
        },
      }

      for _, key in ipairs(keymaps) do
        keymap(key[1], key[2], key[3], key[4])
      end
    end,
  },
}

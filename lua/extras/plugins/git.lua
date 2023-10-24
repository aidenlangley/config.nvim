return {
  {
    'lewis6991/gitsigns.nvim',
    lazy = true,
    event = { 'BufReadPre' },
    cmd = 'Gitsigns',
    keys = {
      {
        ']g',
        "&diff ? ']g' : ':Gitsigns next_hunk<CR>'",
        mode = 'n',
        expr = true,
        desc = 'Goto next hunk',
      },
      {
        '[g',
        "&diff ? '[g' : ':Gitsigns prev_hunk<CR>'",
        mode = 'n',
        expr = true,
        desc = 'Goto prev hunk',
      },
      {
        '<Leader>gb',
        ':Gitsigns blame_line<CR>',
        mode = 'n',
        desc = 'Blame line',
      },
      {
        '<Leader>gB',
        ':Gitsigns toggle_current_line_blame<CR>',
        mode = 'n',
        desc = 'Toggled blame',
      },
      {
        '<Leader>gd',
        ':Gitsigns toggle_deleted<CR>',
        mode = 'n',
        desc = 'Toggled deleted',
      },
      {
        '<Leader>gD',
        ':Gitsigns diffthis<CR>',
        desc = 'Show diff',
      },
      {
        '<Leader>gp',
        ':Gitsigns preview_hunk<CR>',
        mode = 'n',
        desc = 'Preview hunk',
      },
      {
        '<Leader>gs',
        ":execute 'Gitsigns stage_hunk' | Gitsigns next_hunk<CR>",
        mode = { 'n', 'v' },
        desc = 'Stage hunk',
      },
      {
        '<Leader>gu',
        ":execute 'Gitsigns undo_stage_hunk' | Gitsigns prev_hunk<CR>",
        mode = { 'n', 'v' },
        desc = 'Undo stage hunk',
      },
      {
        '<Leader>gr',
        ':Gitsigns reset_hunk<CR>',
        mode = { 'n', 'v' },
        desc = 'Reset hunk',
      },
      {
        '<Leader>gS',
        ':Gitsigns stage_buffer<CR>',
        mode = 'n',
        desc = 'Stage buffer',
      },
      {
        '<Leader>gR',
        ':Gitsigns reset_buffer<CR>',
        mode = 'n',
        desc = 'Reset buffer',
      },
    },
    config = true,
  },
}

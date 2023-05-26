return {
  {
    'lewis6991/gitsigns.nvim',
    lazy = true,
    event = { 'BufReadPre' },
    opts = { preview_config = { border = 'none' } },
    config = function(_, opts)
      require('gitsigns').setup(opts)

      local keys = {
        {
          ']h',
          function()
            require('gitsigns').next_hunk()
          end,
          desc = 'Next hunk',
        },
        {
          '[h',
          function()
            require('gitsigns').prev_hunk()
          end,
          desc = 'Previous hunk',
        },
        {
          '<Leader>gb',
          function()
            require('gitsigns').blame_line({ full = true })
          end,
          desc = 'Blame',
        },
        {
          '<Leader>gD',
          function()
            require('gitsigns').toggle_deleted()
          end,
          desc = 'Toggle Deleted',
        },
        {
          '<Leader>gR',
          function()
            require('gitsigns').reset_buffer()
          end,
          desc = 'Reset buffer',
        },
        {
          '<Leader>gS',
          function()
            require('gitsigns').stage_buffer()
          end,
          desc = 'Stage buffer',
        },
        {
          '<Leader>gu',
          function()
            require('gitsigns').undo_stage_hunk()
          end,
          desc = 'Undo stage',
        },
        {
          '<Leader>gs',
          ':Gitsigns stage_hunk<CR>',
          mode = { 'n', 'v' },
          desc = 'Stage hunk',
        },
        {
          '<Leader>gr',
          ':Gitsigns reset_hunk<CR>',
          mode = { 'n', 'v' },
          desc = 'Reset hunk',
        },
      }

      for _, keymap in ipairs(keys) do
        vim.keymap.set(
          keymap.mode or 'n',
          keymap[1],
          keymap[2],
          { desc = keymap.desc, noremap = true }
        )
      end
    end,
  },
  {
    'sindrets/diffview.nvim',
    lazy = true,
    cmd = {
      'DiffviewOpen',
      'DiffviewClose',
      'DiffviewToggleFiles',
      'DiffviewFocusFiles',
      'DiffviewFileHistory',
    },
    keys = {
      {
        '<Leader>gd',
        ':DiffviewOpen<CR>',
        desc = 'Diff',
      },
      {
        '<Leader>gh',
        ':DiffviewFileHistory<CR>',
        desc = 'History',
      },
    },
    config = true,
  },
}
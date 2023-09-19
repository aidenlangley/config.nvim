return {
  {
    'monaqa/dial.nvim',
    lazy = true,
    keys = {
      { '<C-a>', mode = { 'n', 'v' } },
      { '<C-x>', mode = { 'n', 'v' } },
    },
    config = function()
      local augend = require('dial.augend')
      require('dial.config').augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias['%Y/%m/%d'],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
        },
      })

      vim.keymap.set(
        'n',
        '<C-a>',
        require('dial.map').inc_normal(),
        { desc = 'Dial: Increment' }
      )
      vim.keymap.set(
        'n',
        '<C-x>',
        require('dial.map').dec_normal(),
        { desc = 'Dial: Decrement' }
      )
      vim.keymap.set(
        'v',
        '<C-a>',
        require('dial.map').inc_visual(),
        { desc = 'Dial: Increment' }
      )
      vim.keymap.set(
        'v',
        '<C-x>',
        require('dial.map').dec_visual(),
        { desc = 'Dial: Decrement' }
      )
    end,
  },
  {
    'gbprod/yanky.nvim',
    lazy = true,
    keys = {
      {
        'p',
        '<Plug>(YankyPutAfter)',
        mode = { 'n', 'x' },
        desc = 'Put after',
      },
      {
        'P',
        '<Plug>(YankyPutBefore)',
        mode = { 'n', 'x' },
        desc = 'Put before',
      },
      {
        '<C-n>',
        '<Plug>(YankyCicleForward)',
        desc = 'Cycle yanky forwards',
      },
      {
        '<C-p>',
        '<Plug>(YankyCicleBackward)',
        desc = 'Cycle yanky backwards',
      },
      {
        'gp',
        '<Plug>(YankyGPutAfter)',
        mode = { 'n', 'x' },
        desc = 'GPut after',
      },
      {
        'gP',
        '<Plug>(YankyGPutBefore)',
        mode = { 'n', 'x' },
        desc = 'GPut before',
      },
      {
        'y',
        '<Plug>(YankyYank)',
        mode = { 'n', 'x' },
        desc = '(Y)ank',
      },
      {
        'ty',
        ':YankyRingHistory<CR>',
        desc = 'Yanky history...',
      },
    },
    opts = {
      ring = {
        history_length = 256,
        storage = 'memory',
      },
      highlight = { timer = 150 },
    },
  },
  {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },
}

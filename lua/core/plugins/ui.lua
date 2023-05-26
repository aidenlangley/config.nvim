return {
  {
    'rcarriga/nvim-notify',
    lazy = true,
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      background_colour = require('colours').bg,
    },
    config = function(_, opts)
      require('notify').setup(opts)

      vim.keymap.set('n', '<Leader>un', function()
        require('notify').dismiss({ silent = true, pending = true })
      end, { desc = 'Dismiss all Notifications' })
    end,
  },
}
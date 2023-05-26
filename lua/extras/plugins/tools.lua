return {
  {
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast',
    lazy = true,
    ft = 'markdown',
    keys = {
      {},
    },
    opts = { theme = 'dark' },
    config = function(_, opts)
      require('peek').setup(opts)

      vim.keymap.set('n', '<Leader>op', function()
        local peek = require('peek')
        if peek.is_open() then
          peek.close()
        else
          peek.open()
        end
      end, { desc = 'Open Markdown Preview' })
    end,
  },
}
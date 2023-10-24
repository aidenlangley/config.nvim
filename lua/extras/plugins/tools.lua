return {
  {
    'saimo/peek.nvim',
    build = 'deno task --quiet build:fast',
    lazy = true,
    ft = 'markdown',
    keys = {
      {
        '<Leader>pe',
        function()
          local peek = require('peek')
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        desc = 'Preview markdown',
      },
    },
    opts = {
      theme = 'dark',
      app = 'firefox',
    },
  },
}

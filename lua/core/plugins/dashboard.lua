return {
  {
    'echasnovski/mini.starter',
    opts = function()
      local title = table.concat({
        [[                   |         |         ]],
        [[  __ \    _ \   _` |   _ \   __|   __| ]],
        [[  |   |   __/  (   |  (   |  |   \__ \ ]],
        [[ _|  _| \___| \__,_| \___/  \__| ____/ ]],
      }, '\n')

      local function stats_str(stats)
        return string.format(
          '  %s/%s plugins loaded in %sms 󰄉 ',
          stats.loaded,
          stats.count,
          math.floor(stats.startuptime * 100) / 100
        )
      end

      local ms = require('mini.starter')
      return {
        evaluate_single = true,
        header = function()
          return string.format(
            '%s\n\n%s',
            title,
            stats_str(require('lazy').stats())
          )
        end,
        items = {
          { name = 'Lazy', action = 'Lazy', section = 'Lazy' },
          { name = 'Sync', action = 'Lazy sync', section = 'Lazy' },
          { name = 'Update', action = 'Lazy update', section = 'Lazy' },
          { name = 'Profile', action = 'Lazy profile', section = 'Lazy' },
          { name = 'Log', action = 'Lazy log', section = 'Lazy' },

          { name = 'New', action = 'enew', section = 'Menu' },
          {
            name = 'Settings',
            action = 'e ~/.config/nvim/init.lua',
            section = 'Menu',
          },
          { name = 'Quit', action = 'qa!', section = 'Menu' },

          {
            name = 'Find',
            action = 'Telescope find_files',
            section = 'Telescope',
          },
          {
            name = 'Grep',
            action = 'Telescope live_grep',
            section = 'Telescope',
          },
          {
            name = 'Recent',
            action = 'Telescope oldfiles',
            section = 'Telescope',
          },
          {
            name = 'Help',
            action = 'Telescope help_tags',
            section = 'Telescope',
          },
          {
            name = 'Options',
            action = 'Telescope vim_options',
            section = 'Telescope',
          },

          ms.sections.recent_files(5),
        },
        footer = '',
        content_hooks = {
          ms.gen_hook.adding_bullet(),
          ms.gen_hook.indexing('all', { 'Lazy', 'Menu', 'Telescope' }),
          ms.gen_hook.aligning('center', 'center'),
        },
      }
    end,
    config = function(_, opts)
      -- Lazy is installing missing plugins for us, so we'll come back later
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'MiniStartedOpened',
          callback = function()
            require('lazy').show()
          end,
        })
      end

      require('mini.starter').setup(opts)
    end,
  },
}
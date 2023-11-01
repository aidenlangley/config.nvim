return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function()
      local statusline = require('nedia.core.status_line')
      return {
        options = {
          component_separators = '',
          section_separators = '',
          disabled_filetypes = {
            statusline = {
              'neo-tree',
              'TelescopePrompt',
            },
          },
          ignore_focus = {
            'neo-tree',
          },
          refresh = {
            statusline = 250,
          },
        },
        extensions = {
          'toggleterm',
        },
        sections = {
          lualine_a = { statusline.mode },
          lualine_b = { statusline.filename },
          lualine_c = { statusline.diagnostics },
          lualine_x = { statusline.clients },
          lualine_y = { statusline.diff, 'branch' },
          lualine_z = { 'selectioncount', 'location', 'progress' },
        },
      }
    end,
  },
}

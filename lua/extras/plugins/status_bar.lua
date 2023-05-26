return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = true,
    event = 'VeryLazy',
    opts = function()
      local icons = require('icons')
      local colours = require('colours')

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
          ignore_focus = { 'neo-tree' },
          refresh = { statusline = 250 },
        },
        extensions = { 'toggleterm' },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            {
              'filetype',
              colored = true,
              icon_only = true,
            },
            {
              'filename',
              file_status = true,
              newfile_status = false,
              path = 1,
              shorting_target = 40,
              symbols = {
                modified = icons.git.modified,
                readonly = icons.git.removed,
                unnamed = '[No Name]',
                newfile = icons.git.added,
              },
            },
          },
          lualine_c = {
            {
              'diagnostics',
              sources = { 'nvim_lsp', 'nvim_diagnostic' },
              sections = { 'error', 'warn', 'info', 'hint' },
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
              diagnostics_color = {
                color_error = { fg = colours.neutral_red },
                color_warn = { fg = colours.neutral_yellow },
                color_info = { fg = colours.neutral_aqua },
                color_hint = { fg = colours.neutral_grey },
              },
            },
          },
          lualine_x = {
            {
              'clients',
              fmt = function()
                local clients = {}
                for _, c in
                  ipairs(vim.lsp.get_active_clients({
                    bufnr = vim.api.nvim_get_current_buf(),
                  }))
                do
                  -- When handling null-ls clients, we have to further inspect the sources
                  if c.name == 'null-ls' then
                    for _, s in
                      ipairs(
                        require('null-ls.sources').get_available(
                          vim.bo.filetype
                        )
                      )
                    do
                      clients[#clients + 1] = s.name
                    end
                  else
                    clients[#clients + 1] = c.name
                  end
                end

                local duplicates = {}
                local squashed = {}
                for _, v in ipairs(clients) do
                  if not duplicates[v] then
                    squashed[#squashed + 1] = v
                    duplicates[v] = true
                  end
                end

                return table.concat(squashed, ' '), ' '
              end,
            },
            {
              'diff',
              colored = true,
              diff_color = {
                color_added = { fg = colours.neutral_green },
                color_modified = { fg = colours.neutral_yellow },
                color_removed = { fg = colours.neutral_red },
              },
              symbols = {
                added = icons.git.added .. ' ',
                modified = icons.git.modified .. ' ',
                removed = icons.git.removed .. ' ',
              },
            },
          },
          lualine_y = { 'branch' },
          lualine_z = { 'location' },
        },
      }
    end,
  },
}
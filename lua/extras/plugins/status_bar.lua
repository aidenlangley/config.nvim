return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
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
                local bufnr = vim.api.nvim_get_current_buf()
                local clients = {}
                for _, client in
                  ipairs(vim.lsp.get_active_clients({ bufnr = bufnr }))
                do
                  clients[#clients + 1] = client.name
                end

                for _, formatter in
                  ipairs(require('conform').list_formatters_for_buffer(bufnr))
                do
                  table.insert(clients, formatter)
                end

                local linters = require('lint').linters_by_ft[vim.bo.filetype]
                if linters then
                  for _, linter in ipairs(linters) do
                    table.insert(clients, linter)
                  end
                end

                return table.concat(clients, ' '), '  '
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

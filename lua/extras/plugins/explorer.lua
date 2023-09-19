return {
  {
    'ahmedkhalf/project.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      patterns = {
        '.bzr',
        '.git',
        '.gitattributes',
        '.gitignore',
        '.hg',
        '.svn',
        'Makefile',
        '_darcs',
        'package.json',
        'pubspec.yaml',
      },
    },
    config = function(_, opts)
      require('project_nvim').setup(opts)
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    lazy = true,
    cmd = 'Neotree',
    keys = {
      {
        '<C-e>',
        ':Neotree toggle<CR>',
        desc = 'Explorer (NeoTree)',
        noremap = true,
        silent = true,
      },
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1

      -- Opening a directory will load neo-tree.
      -- hijack_netrw_behavior = "open_default" does the rest.
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(tostring(vim.fn.argv(0)))
        if stat and stat.type == 'directory' then
          require('neo-tree')
        end
      end
    end,
    opts = function()
      local icons = require('icons')
      return {
        close_if_last_window = true,
        filesystem = {
          use_libuv_file_watcher = true,
          filtered_items = { visible = true },
        },
        window = {
          position = 'right',
          width = 32,
        },
        default_component_configs = {
          indent = {
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = '',
            expander_expanded = '',
            expander_highlight = 'NeoTreeExpander',
          },
          git_status = {
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              deleted = '✖',
              renamed = '',
              untracked = '?',
              ignored = '',
              unstaged = icons.git.removed,
              staged = '',
              conflict = '',
            },
          },
        },
      }
    end,
    config = function(_, opts)
      require('neo-tree').setup(opts)

      vim.api.nvim_create_autocmd('TermClose', {
        pattern = '*lazygit',
        callback = function()
          if package.loaded['neo-tree.sources.git_status'] then
            require('neo-tree.sources.git_status').refresh()
          end
        end,
      })
    end,
  },
}
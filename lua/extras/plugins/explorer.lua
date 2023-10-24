return {
  {
    'ahmedkhalf/project.nvim',
    main = 'project_nvim',
    dependencies = {
      {
        'nvim-telescope/telescope.nvim',
        config = function(_, _)
          require('telescope').load_extension('projects')
        end,
      },
    },
    lazy = true,
    keys = {
      {
        'tp',
        ':Telescope projects<CR>',
        desc = 'Projects',
      },
    },
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
      -- Opening a directory will load neo-tree.
      -- hijack_netrw_behavior = "open_default" does the rest.
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(tostring(vim.fn.argv(0)))
        if stat and stat.type == 'directory' then
          require('neo-tree')
        end
      end

      vim.g.neo_tree_remove_legacy_commands = 1
      vim.api.nvim_create_autocmd('TermClose', {
        pattern = '*lazygit',
        callback = function()
          if package.loaded['neo-tree.sources.git_status'] then
            require('neo-tree.sources.git_status').refresh()
          end
        end,
      })
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
          -- position = 'right',
          width = 28,
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
  },
}

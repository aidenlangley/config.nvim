return {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    opts = {
      italic = {
        strings = false,
        comments = false,
        operators = false,
        folds = false,
      },
      contrast = 'hard',
      transparent_mode = true,
    },
  },
  {
    'echasnovski/mini.starter',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'ahmedkhalf/project.nvim',
    },
    opts = function()
      local dashboard = require('nedia.core.dashboard')
      return {
        evaluate_single = true,
        header = dashboard.header,
        items = dashboard.items,
        footer = dashboard.footer,
        content_hooks = nil,
      }
    end,
    config = function(_, opts)
      if vim.o.filetype == 'lazy' then
        vim.api.nvim_create_autocmd('User', {
          pattern = 'MiniStartedOpened',
          callback = function()
            require('lazy').show()
          end,
        })
        vim.cmd.close()
      end

      local starter = require('mini.starter')
      table.insert(opts.items, starter.sections.recent_files(5))
      opts.content_hooks = {
        starter.gen_hook.adding_bullet(),
        starter.gen_hook.indexing('all', { 'Lazy', 'Menu', 'Telescope' }),
        starter.gen_hook.aligning('center', 'center'),
      }
      starter.setup(opts)

      require('telescope').load_extension('projects')
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
    },
    opts = {
      defaults = {
        path_display = { 'smart' },
        dynamic_preview_title = true,
      },
    },
    config = function(_, opts)
      require('telescope').setup(opts)
      require('telescope').load_extension('fzf')

      local keymaps = {
        { 'n', 'tt', '', { desc = 'Telescope' } },
        { 'n', '<Leader><Space>', 'buffers', { desc = 'Buffers' } },
        { 'n', 'th', 'help_tags', { desc = 'Help' } },
        { 'n', '<C-f>', 'current_buffer_fuzzy_find', { desc = 'Fuzzy find' } },
        { 'n', { 'tg', '<CS-f>' }, 'live_grep', { desc = 'Grep' } },
        { 'n', 'tf', 'fd theme=dropdown', { desc = 'Find files' } },
        { 'n', 'td', 'diagnostics theme=ivy', { desc = 'Errors' } },
        { 'n', 'tr', 'oldfiles theme=dropdown', { desc = 'Recent files' } },
      }

      local utils = require('nedia.utils')
      for _, key in ipairs(keymaps) do
        utils.keymap(
          key[1],
          key[2],
          utils.cmd('Telescope' .. (key[3] or 'Telescope')),
          key[4]
        )
      end
    end,
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      key_labels = {
        ['<leader>'] = 'SPC',
        ['<Leader>'] = 'SPC',
        ['<space>'] = 'SPC',
        ['<Space>'] = 'SPC',
      },
      window = { border = 'single' },
      show_help = true,
      show_keys = true,
      disable = {
        filetypes = {
          'neo-tree',
          'TelescopePrompt',
        },
      },
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'BufReadPost',
    opts = {
      scope = {
        show_start = false,
        show_end = false,
      },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'lazy',
        },
      },
    },
  },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    config = true,
  },
  {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'smjonas/inc-rename.nvim',
      {
        'rcarriga/nvim-notify',
        opts = { background_colour = require('nedia.colours').bg },
      },
    },
    event = 'VeryLazy',
    keys = {
      { '<Leader>dm', ':Noice dismiss<CR>', desc = 'Dismiss notifications' },
      { '<Leader>nof', ':Noice disable<CR>', desc = 'Disable notifications' },
      { '<Leader>non', ':Noice enable<CR>', desc = 'Enable notifications' },
    },
    opts = {
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
      lsp = {
        progress = { enabled = true },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          view = 'notify',
          filter = { event = 'msg_showmode' },
        },
        {
          view = 'mini',
          filter = { event = 'msg_show', kind = '', find = 'written' },
        },
      },
    },
  },
  {
    'NvChad/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
      filetypes = { '*', '!lazy' },
      buftype = { '*', '!prompt', '!nofile' },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn = true,
        hsl_fn = true,
        css = false,
        css_fn = true,
        mode = 'background',
        virtualtext = '■',
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
    cmd = 'Neotree',
    keys = {
      {
        '<C-e>',
        ':Neotree toggle<CR>',
        desc = 'Explorer',
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
      local icons = require('nedia.icons')
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
              added = icons.GitAdd,
              modified = icons.GitChange,
              deleted = '✖',
              renamed = '',
              untracked = '?',
              ignored = '',
              unstaged = icons.GitUnstaged,
              staged = '',
              conflict = '',
            },
          },
        },
      }
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    keys = { '<C-\\>' },
    opts = {
      open_mapping = '<C-\\>',
      direction = 'float',
      shell = '/usr/bin/fish',
    },
  },
  {
    'saimo/peek.nvim',
    build = 'deno task --quiet build:fast',
    ft = 'markdown',
    keys = {
      {
        '<Leader>pe',
        function()
          ---@type table
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

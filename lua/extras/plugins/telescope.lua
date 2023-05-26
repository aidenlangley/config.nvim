return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
          require('telescope').load_extension('fzf')
        end,
      },
      {
        'ahmedkhalf/project.nvim',
        main = 'project_nvim',
      },
    },
    optional = true,
    module = false,
    lazy = true,
    keys = {
      { '<Leader><Space>', mode = 'n' },
      { '<C-f>', mode = 'n' },
      { 't', mode = 'n' },
      { 'g', mode = { 'n', 'v' } },
    },
    opts = {
      defaults = {
        path_display = { 'smart' },
        dynamic_preview_title = true,
      },
      pickers = {},
    },
    config = function(_, opts)
      for _, v in ipairs({
        'buffers',
        'builtin',
        'current_buffer_fuzzy_find',
        'find_files',
        'live_grep',
      }) do
        opts.pickers[v] = { theme = 'dropdown' }
      end

      for _, v in ipairs({
        'diagnostics',
      }) do
        opts.pickers[v] = { theme = 'ivy' }
      end

      require('telescope').setup(opts)

      local ts_keymaps = {
        {
          'tt',
          function()
            require('telescope.builtin').builtin()
          end,
          desc = 'Builtins...',
        },
        {
          '<Leader><Space>',
          function()
            require('telescope.builtin').buffers()
          end,
          desc = 'Buffers...',
        },
        {
          'tf',
          function()
            require('telescope.builtin').find_files()
          end,
          desc = 'Find files...',
        },
        {
          'tg',
          function()
            require('telescope.builtin').live_grep()
          end,
          desc = 'Live grep...',
        },
        {
          '<C-f>',
          function()
            require('telescope.builtin').current_buffer_fuzzy_find()
          end,
          desc = 'Fuzzy find...',
        },
        {
          'td',
          function()
            require('telescope.builtin').diagnostics()
          end,
          desc = 'Diagnostics...',
        },
        {
          'tr',
          function()
            require('telescope.builtin').oldfiles()
          end,
          desc = 'Recent files...',
        },
        {
          'th',
          function()
            require('telescope.builtin').help_tags()
          end,
          desc = 'Help...',
        },
        {
          'tp',
          function()
            require('telescope').extensions.projects.projects({})
          end,
          desc = 'Projects...',
        },
      }

      for _, keymap in ipairs(ts_keymaps) do
        vim.keymap.set(keymap.mode or 'n', keymap[1], keymap[2], {
          desc = keymap.desc or string.format('Telescope%n', #ts_keymaps + 1),
        })
      end
    end,
  },
}
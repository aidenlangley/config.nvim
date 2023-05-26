return {
  {
    'nvim-telescope/telescope.nvim',
    name = 'telescope-full',
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
    },
    config = function(_, opts)
      for i, v in ipairs({
        {
          'tt',
          require('telescope.builtin').builtin,
          desc = 'Builtins',
        },
        {
          '<Leader><Space>',
          require('telescope.builtin').buffers,
          desc = 'Buffers',
        },
        {
          'tf',
          require('telescope.builtin').find_files,
          desc = 'Find files',
        },
        {
          'tg',
          require('telescope.builtin').live_grep,
          desc = 'Live grep',
        },
        {
          '<C-f>',
          require('telescope.builtin').current_buffer_fuzzy_find,
          desc = 'Fuzzy find',
        },
        {
          'td',
          require('telescope.builtin').diagnostics,
          desc = 'Diagnostics',
        },
        {
          'tr',
          require('telescope.builtin').oldfiles,
          desc = 'Recent files',
        },
        {
          'th',
          require('telescope.builtin').help_tags,
          desc = 'Help',
        },
        {
          'tk',
          require('telescope.builtin').keymaps,
          desc = 'Projects',
        },
        {
          'tp',
          require('telescope').extensions.projects.projects,
          desc = 'Projects',
        },
      }) do
        vim.keymap.set(v.mode or 'n', v[1], v[2], {
          desc = v.desc or string.format('Telescope%n', i),
        })
      end

      require('telescope').setup(opts)
    end,
  },
}
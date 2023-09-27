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
      { '<C-f>', mode = 'n' },
      { '<Leader><Space>', mode = 'n' },
      { '[', mode = 'n' },
      { ']', mode = 'n' },
      { 'b', mode = 'n' },
      { 'g', mode = { 'n', 'v' } },
      { 't', mode = 'n' },
      { 'w', mode = 'n' },
    },
    opts = {
      defaults = {
        path_display = { 'smart' },
        dynamic_preview_title = true,
      },
    },
    config = function(_, opts)
      local keymaps = {
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
          desc = 'Keymaps',
        },
        {
          'tp',
          require('telescope').extensions.projects.projects,
          desc = 'Projects',
        },
      }

      for i, v in ipairs(keymaps) do
        local desc
        if v.desc then
          desc = string.format('Telescope: %s', v.desc)
        else
          desc = string.format('Telescope%n', i)
        end

        vim.keymap.set(v.mode or 'n', v[1], v[2], { desc = desc })
      end

      require('telescope').setup(opts)
    end,
  },
}

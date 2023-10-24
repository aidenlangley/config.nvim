return {
  {
    'nvim-telescope/telescope.nvim',
    name = 'telescope-full',
    main = 'telescope',
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
          require('telescope').load_extension('fzf')
        end,
      },
    },
    lazy = true,
    keys = {
      { 'tt', ':Telescope<CR>', mode = 'n', desc = 'Telescope' },
      { '<Leader><Space>', ':Telescope buffers<CR>', desc = 'Buffers' },
      { '<C-f>', ':Telescope current_buffer_fuzzy_find<CR>', desc = 'Search' },
      { '<CS-f>', ':Telescope live_grep<CR>', desc = 'Grep' },
      { 'tf', ':Telescope fd theme=dropdown<CR>', desc = 'Find files' },
      { 'td', ':Telescope diagnostics theme=ivy<CR>', desc = 'Diagnostics' },
      { 'tr', ':Telescope oldfiles theme=dropdown<CR>', desc = 'Recent files' },
      { 'th', ':Telescope help_tags<CR>', desc = 'Help' },
      { '[', mode = 'n' },
      { ']', mode = 'n' },
      { 'g', mode = { 'n', 'v' } },
    },
    opts = {
      defaults = {
        path_display = { 'smart' },
        dynamic_preview_title = true,
      },
    },
  },
}

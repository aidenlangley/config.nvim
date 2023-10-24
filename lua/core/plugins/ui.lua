return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    lazy = true,
    event = 'BufReadPost',
    opts = {
      scope = { show_start = false },
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
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'smjonas/inc-rename.nvim',
      {
        'rcarriga/nvim-notify',
        lazy = true,
        opts = { background_colour = require('colours').bg },
      },
      {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        keys = {
          {
            'tn',
            ':Noice telescope<CR>',
            desc = 'Message history',
          },
        },
        config = function(_, _)
          require('telescope').load_extension('noice')
        end,
      },
    },
    lazy = true,
    event = 'VeryLazy',
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
}

return {
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPost',
    opts = {
      char = '│',
      filetype_exclude = {
        'help',
        'alpha',
        'dashboard',
        'neo-tree',
        'Trouble',
        'lazy',
      },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },
  {
    'petertriho/nvim-scrollbar',
    lazy = true,
    event = 'BufAdd',
    opts = {
      excluded_filestypes = {
        'prompt',
        'TelescopePrompt',
        'neo-tree',
        'notify',
      },
    },
  },
  {
    'stevearc/dressing.nvim',
    init = function()
      vim.ui.select = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.input(...)
      end
    end,
  },
  {
    'anuvyklack/windows.nvim',
    dependencies = { 'anuvyklack/middleclass' },
    lazy = true,
    event = 'BufAdd',
    config = true,
  },
  {
    'b0o/incline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = true,
    event = 'BufAdd',
    opts = {
      render = function(props)
        local fn =
          vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
        local i, c = require('nvim-web-devicons').get_icon_color(fn)
        return { { i, guifg = c }, { ' ' }, { fn } }
      end,
    },
  },
}
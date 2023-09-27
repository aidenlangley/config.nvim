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
    enabled = false,
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
  {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    enabled = true,
    event = 'VeryLazy',
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            find = '%d+L, %d+B',
          },
          view = 'mini',
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
    keys = {
      {
        '<S-Enter>',
        function()
          require('noice').redirect(vim.fn.getcmdline())
        end,
        mode = 'c',
        desc = 'Redirect cmdline',
      },
      {
        '<Leader>snl',
        function()
          require('noice').cmd('last')
        end,
        desc = 'Noice: Last message',
      },
      {
        '<Leader>snh',
        function()
          require('noice').cmd('history')
        end,
        desc = 'Noice: History',
      },
      {
        '<Leader>sna',
        function()
          require('noice').cmd('all')
        end,
        desc = 'Noice: All',
      },
      {
        '<Leader>dd',
        function()
          require('noice').cmd('dismiss')
        end,
        desc = 'Dismiss all',
      },
      {
        '<C-f>',
        function()
          if not require('noice.lsp').scroll(4) then
            return '<C-f>'
          end
        end,
        silent = true,
        expr = true,
        desc = 'Scroll forward',
        mode = { 'i', 'n', 's' },
      },
      {
        '<C-b>',
        function()
          if not require('noice.lsp').scroll(-4) then
            return '<C-b>'
          end
        end,
        silent = true,
        expr = true,
        desc = 'Scroll backward',
        mode = { 'i', 'n', 's' },
      },
    },
  },
}

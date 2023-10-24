return {
  {
    'echasnovski/mini.ai',
    main = 'mini.ai',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    version = false,
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function()
      local ts = require('mini.ai').gen_spec.treesitter
      return {
        custom_textobjects = {
          f = ts({
            a = { '@function.outer', '@method.outer' },
            i = { '@function.inner', '@method.inner' },
          }, {}),
          c = ts({ a = '@class.outer', i = '@class.inner' }, {}),
          a = ts({ a = '@parameter.outer', i = '@parameter.inner' }, {}),
          b = ts({ a = '@block.outer', i = '@block.inner' }, {}),
          g = ts({ a = '@call.outer', i = '@call.inner' }, {}),
          l = ts({ a = '@loop.outer', i = '@loop.inner' }, {}),
          o = ts({ a = '@conditional.outer', i = '@conditional.inner' }, {}),
          d = ts({ a = '@comment.outer', i = '@comment.inner' }, {}),

          -- Whole buffer
          G = function()
            local from = { line = 1, col = 1 }

            local last_line = vim.fn.line('$')
            local to = {
              line = last_line,
              col = math.max(last_line:len(), 1),
            }

            return { from = from, to = to }
          end,
        },
      }
    end,
  },
  {
    'echasnovski/mini.bufremove',
    main = 'mini.bufremove',
    version = false,
    lazy = true,
  },
  {
    'echasnovski/mini.comment',
    main = 'mini.comment',
    version = false,
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    lazy = true,
    event = 'BufReadPost',
    opts = {
      hooks = {
        pre = function()
          require('ts_context_commentstring.internal').update_commentstring({})
        end,
      },
    },
  },
  {
    'echasnovski/mini.cursorword',
    main = 'mini.cursorword',
    version = false,
    lazy = true,
    event = 'BufReadPost',
    config = true,
  },
  {
    'echasnovski/mini.surround',
    main = 'mini.surround',
    version = false,
    lazy = true,
    event = 'BufReadPost',
    opts = {
      mappings = {
        add = 'ys', -- ysiw( will surround a word with brackets
        delete = 'ds', -- ds( will delete the brackets
        find = '',
        find_left = '',
        highlight = '',
        replace = 'cs', -- cs([ will turn brackets to square brackets
        update_n_lines = '',
        suffix_last = '',
        suffix_next = '',
      },
      custom_surroundings = {
        -- There are spaces within the brackets by default - this removes
        -- them.
        ['('] = { output = { left = '(', right = ')' } },
        [')'] = { output = { left = '(', right = ')' } },
        ['['] = { output = { left = '[', right = ']' } },
        [']'] = { output = { left = '[', right = ']' } },
        ['{'] = { output = { left = '{', right = '}' } },
        ['}'] = { output = { left = '{', right = '}' } },
      },
    },
    config = function(_, opts)
      require('mini.surround').setup(opts)
      vim.api.nvim_set_keymap('n', 'yss', 'ys_', { noremap = false })
    end,
  },
  {
    'echasnovski/mini.tabline',
    main = 'mini.tabline',
    version = false,
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },
}

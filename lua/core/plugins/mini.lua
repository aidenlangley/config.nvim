return {
  {
    'echasnovski/mini.ai',
    version = false,
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function()
      local ai = require('mini.ai')
      return {
        n_lines = 500,
        custom_textobjects = {
          a = ai.gen_spec.treesitter({
            a = '@parameter.outer',
            i = '@parameter.inner',
          }, {}),
          b = ai.gen_spec.treesitter({
            a = '@block.outer',
            i = '@block.inner',
          }, {}),
          c = ai.gen_spec.treesitter({
            a = '@class.outer',
            i = '@class.inner',
          }, {}),
          d = ai.gen_spec.treesitter({
            a = '@comment.outer',
            i = '@comment.inner',
          }, {}),
          f = ai.gen_spec.treesitter({
            a = { '@function.outer', '@method.outer' },
            i = { '@function.inner', '@method.inner' },
          }, {}),
          g = ai.gen_spec.treesitter({
            a = '@call.outer',
            i = '@call.inner',
          }, {}),
          l = ai.gen_spec.treesitter({
            a = '@loop.outer',
            i = '@loop.inner',
          }, {}),
          o = ai.gen_spec.treesitter({
            a = '@conditional.outer',
            i = '@conditional.inner',
          }, {}),
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
    config = function(_, opts)
      require('mini.ai').setup(opts)
    end,
  },
  {
    'echasnovski/mini.animate',
    version = false,
    enabled = true,
    lazy = true,
    event = 'BufAdd',
    opts = function()
      local mouse_scrolled = false
      for _, scroll in ipairs({ 'Up', 'Down' }) do
        local key = '<ScrollWheel' .. scroll .. '>'
        vim.keymap.set('', key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local is_not_single_window = function(win_id)
        local tabpage_id = vim.api.nvim_win_get_tabpage(win_id)
        return #vim.api.nvim_tabpage_list_wins(tabpage_id) > 1
      end

      local animate = require('mini.animate')
      return {
        scroll = {
          timing = animate.gen_timing.linear({ duration = 150, unit = 'total' }),
          subscroll = animate.gen_subscroll.equal({
            max_output_steps = 120,
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
        open = {
          winconfig = animate.gen_winconfig.wipe({
            predicate = is_not_single_window,
            direction = 'from_edge',
          }),
        },
        close = {
          winconfig = animate.gen_winconfig.wipe({
            predicate = is_not_single_window,
            direction = 'to_edge',
          }),
        },
      }
    end,
    config = function(_, opts)
      require('mini.animate').setup(opts)
    end,
  },
  {
    'echasnovski/mini.bufremove',
    version = false,
    lazy = true,
  },
  {
    'echasnovski/mini.comment',
    version = false,
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    lazy = true,
    event = 'BufReadPost',
    opts = {
      mappings = {
        comment = 'gc',
        comment_line = 'gcc',
        textobject = 'gc',
      },
      hooks = {
        pre = function()
          require('ts_context_commentstring.internal').update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require('mini.comment').setup(opts)
    end,
  },
  {
    'echasnovski/mini.cursorword',
    version = false,
    lazy = true,
    event = 'BufAdd',
    config = function()
      require('mini.cursorword').setup({})
    end,
  },
  {
    'echasnovski/mini.indentscope',
    enabled = false,
    version = false,
    lazy = true,
    event = 'BufReadPost',
    opts = {
      symbol = '│',
      options = { try_as_border = true },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'lazy',
          'mason',
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require('mini.indentscope').setup(opts)
    end,
  },
  {
    'echasnovski/mini.hipatterns',
    enabled = false,
    version = false,
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function()
      local hipatterns = require('mini.hipatterns')
      return {
        highlighters = {
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }
    end,
    config = function(_, opts)
      require('mini.indentscope').setup(opts)
    end,
  },
  {
    'echasnovski/mini.surround',
    version = false,
    lazy = true,
    keys = {
      { 'ys', mode = { 'n', 'v', 'o' } },
      { 'ds', mode = { 'n', 'v', 'o' } },
      { 'cs', mode = { 'n', 'v', 'o' } },
      { 'yss', mode = 'n' },
    },
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
    version = false,
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('mini.tabline').setup({})
    end,
  },
}

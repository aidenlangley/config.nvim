return {
  {
    "https://git.sr.ht/~nedia/auto-format.nvim",
    event = "BufReadPost",
    config = true,
    dev = false,
  },
  {
    "https://git.sr.ht/~nedia/auto-save.nvim",
    event = "BufReadPost",
    opts = {
      events = { "InsertLeave", "BufLeave" },
      silent = false,
      exclude_ft = { "neo-tree" },
    },
    dev = false,
  },
  {
    "mcauley-penney/tidy.nvim",
    event = "BufReadPost",
    config = true,
  },
  {
    "echasnovski/mini.surround",
    keys = {
      { "ys", mode = { "n", "v", "o" } },
      { "ds", mode = { "n", "v", "o" } },
      { "cs", mode = { "n", "v", "o" } },
      { "yss", mode = "n" },
    },
    opts = {
      mappings = {
        add = "ys", -- ysiw( will surround a word with brackets
        delete = "ds", -- ds( will delete the brackets
        find = "",
        find_left = "",
        highlight = "",
        replace = "cs", -- cs([ will turn brackets to square brackets
        update_n_lines = "",
        suffix_last = "",
        suffix_next = "",
      },
      custom_surroundings = {
        -- There are spaces within the brackets by default - this removes
        -- them.
        ["("] = { output = { left = "(", right = ")" } },
        [")"] = { output = { left = "(", right = ")" } },
        ["["] = { output = { left = "[", right = "]" } },
        ["]"] = { output = { left = "[", right = "]" } },
        ["{"] = { output = { left = "{", right = "}" } },
        ["}"] = { output = { left = "{", right = "}" } },
      },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
      vim.api.nvim_set_keymap("n", "yss", "ys_", { noremap = false })
    end,
  },
  {
    "echasnovski/mini.ai",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    keys = {
      { "a", mode = { "v", "o" } },
      { "i", mode = { "v", "o" } },
    },
    event = "BufReadPost",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          a = ai.gen_spec.treesitter({
            a = "@parameter.outer",
            i = "@parameter.inner",
          }, {}),
          b = ai.gen_spec.treesitter({
            a = "@block.outer",
            i = "@block.inner",
          }, {}),
          c = ai.gen_spec.treesitter({
            a = "@class.outer",
            i = "@class.inner",
          }, {}),
          d = ai.gen_spec.treesitter({
            a = "@comment.outer",
            i = "@comment.inner",
          }, {}),
          f = ai.gen_spec.treesitter({
            a = { "@function.outer", "@method.outer" },
            i = { "@function.inner", "@method.inner" },
          }, {}),
          g = ai.gen_spec.treesitter({
            a = "@call.outer",
            i = "@call.inner",
          }, {}),
          -- Whole buffer
          G = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line("$"),
              ---@diagnostic disable-next-line: param-type-mismatch, undefined-field
              col = math.max(vim.fn.getline("$"):len(), 1),
            }
            return { from = from, to = to }
          end,
          l = ai.gen_spec.treesitter({
            a = "@loop.outer",
            i = "@loop.inner",
          }, {}),
          o = ai.gen_spec.treesitter({
            a = "@conditional.outer",
            i = "@conditional.inner",
          }, {}),
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    enabled = true,
    config = true,
  },
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    enabled = false,
    opts = {
      mappings = {
        ["("] = {
          action = "closeopen",
          pair = "()",
          neigh_pattern = "[^%a\\].",
          register = { cr = false },
        },
        ["{"] = {
          action = "closeopen",
          pair = "{}",
          neigh_pattern = "[^%a\\].",
          register = { cr = false },
        },
        ["["] = {
          action = "closeopen",
          pair = "[]",
          neigh_pattern = "[^%a\\].",
          register = { cr = false },
        },
      },
    },
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },
  {
    "ggandor/leap.nvim",
    keys = {
      { "s", mode = { "n", "v", "o" } },
      { "S", mode = { "n", "v", "o" } },
    },
    config = function()
      require("leap").set_default_keymaps()
    end,
  },

  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<Leader>d",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "(D)elete buffer",
        noremap = true,
      },
    },
  },
  {
    "echasnovski/mini.cursorword",
    event = "BufReadPost",
    config = function()
      require("mini.cursorword").setup({})
    end,
  },

  {
    "echasnovski/mini.doc",
    event = "VeryLazy",
    config = function()
      require("mini.doc").setup({})
    end,
  },
  {
    "danymat/neogen",
    keys = {
      {
        "<Leader>cc",
        function()
          require("neogen").generate({})
        end,
        desc = "Generate docs",
      },
    },
    opts = { snippet_engine = "luasnip" },
  },
  {
    "simrat39/symbols-outline.nvim",
    keys = {
      {
        "<Leader>ls",
        require("utils").cmd("SymbolsOutline"),
        desc = "View (S)ymbols",
      },
    },
    opts = { width = 28 },
  },
  "gpanders/editorconfig.nvim",
  {
    "mg979/vim-visual-multi",
    keys = {
      "<C-n>", -- Selects word incrementally
      "<M-n>", -- Selects all words
      "<C-Down>",
      "<C-Left>",
      "<C-Right>",
      "<C-Up>",
    },
    config = function()
      vim.g.multi_cursor_start_word_key = "<C-n>"
      vim.g.multi_cursor_select_all_word_key = "<M-n>"
      vim.g.multi_cursor_start_key = "g<C-n>"
      vim.g.multi_cursor_select_all_key = "g<M-n>"
      vim.g.multi_cursor_next_key = "<C-n>"
      vim.g.multi_cursor_prev_key = "<C-p>"
      vim.g.multi_cursor_skip_key = "<C-x>"
      vim.g.multi_cursor_quit_key = "<Esc>"
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      filetypes = { "*", "!lazy" },
      buftype = { "*", "!prompt", "!nofile" },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        AARRGGBB = false,
        rgb_fn = true,
        hsl_fn = true,
        css = false,
        css_fn = true,
        mode = "background",
        virtualtext = "■",
      },
    },
  },
  {
    "monaqa/dial.nvim",
    keys = {
      { "<C-a>", mode = { "n", "v" } },
      { "<C-x>", mode = { "n", "v" } },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
        },
      })

      vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { desc = "Dial: Increment" })
      vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { desc = "Dial: Decrement" })
      vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), { desc = "Dial: Increment" })
      vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), { desc = "Dial: Decrement" })
    end,
  },
  {
    "windwp/nvim-spectre",
    keys = {
      {
        "<Leader>rs",
        function()
          require("spectre").open()
        end,
        desc = "(R)eplace in files (Spectre)",
      },
    },
  },
  {
    "andymass/vim-matchup",
    event = "BufReadPre",
    config = function()
      vim.g.matchup_motion_enabled = 0
      vim.g.matchup_surround_enabled = 0
      vim.g.matchup_text_obj_linewise_operators = {}
      vim.g.matchup_transmute_enabled = 0

      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_hi_surround_always = 1
      vim.g.matchup_matchparen_offscreen = { method = "popup" }

      local colours = require("config.colours").THEME
      vim.api.nvim_set_hl(0, "MatchParenCur", {
        fg = colours.grey,
        bg = colours.bg,
      })
    end,
  },
  {
    "gbprod/yanky.nvim",
    keys = {
      { "p", "<Plug>(YankyPutAfter)", desc = "Put after" },
      { "P", "<Plug>(YankyPutBefore)", desc = "Put before" },
      { "gp", "<Plug>(YankyGPutAfter)", desc = "GPut after" },
      { "gP", "<Plug>(YankyGPutBefore)", desc = "GPut before" },
      { "<C-p>", "<Plug>(YankyCycleBackward)", desc = "Cycle yank backwards" },
      { "<C-P>", "<Plug>(YankyCycleForward)", desc = "Cycle yank forwards" },
      { "y", "<Plug>(YankyYank)", desc = "(Y)ank" },
    },
    opts = function()
      local mapping = require("yanky.telescope.mapping")
      return {
        highlight = { timer = 150 },
        picker = {
          telescope = {
            mappings = {
              i = {
                ["<C-k"] = nil,
                ["<C-P>"] = mapping.put("P"),
              },
            },
          },
        },
      }
    end,
  },
}

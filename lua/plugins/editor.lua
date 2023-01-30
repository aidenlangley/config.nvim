return {
  {
    "https://git.sr.ht/~nedia/auto-format.nvim",
    event = "BufReadPost",
    config = true,
    dev = false,
  },
  {
    "https://git.sr.ht/~nedia/auto-save.nvim",
    event = "BufModifiedSet",
    opts = {
      events = { "InsertLeave", "BufLeave" },
      silent = false,
      exclude_ft = { "neo-tree" },
    },
    dev = false,
  },
  {
    "mcauley-penney/tidy.nvim",
    event = "BufModifiedSet",
    config = true,
  },
  {
    "echasnovski/mini.surround",
    keys = {
      "ys",
      "ds",
      "cs",
      { "ys", mode = "v" },
      { "ds", mode = "v" },
      { "cs", mode = "v" },
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
      },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
    end,
  },
  {
    "echasnovski/mini.ai",
    event = "BufReadPost",
    opts = { custom_textobjects = {} },
    config = function(_, opts)
      require("mini.ai").setup(opts)
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "ggandor/leap.nvim",
    keys = { "s", "S" },
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
      require("mini.cursorword").setup({})
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
        desc = "Neogen: (G)enerate docs",
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
        desc = "LSP: View (S)ymbols",
      },
    },
    opts = { width = 28 },
  },
  "gpanders/editorconfig.nvim",
  {
    "mg979/vim-visual-multi",
    keys = {
      "<C-n>", -- Selects word incrementally
      "<A-n>", -- Selects all words
      "<C-Down>",
      "<C-Left>",
      "<C-Right>",
      "<C-Up>",
    },
    config = function()
      vim.g.multi_cursor_start_word_key = "<C-n>"
      vim.g.multi_cursor_select_all_word_key = "<A-n>"
      vim.g.multi_cursor_start_key = "g<C-n>"
      vim.g.multi_cursor_select_all_key = "g<A-n>"
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
      "<C-a>",
      "<C-x>",
      { "<C-a>", mode = "v" },
      { "<C-x>", mode = "v" },
      { "g<C-a>", mode = "v" },
      { "g<C-x>", mode = "v" },
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

      vim.api.nvim_set_keymap(
        "n",
        "<C-a>",
        require("dial.map").inc_normal(),
        { desc = "Dial: Increment" }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<C-x>",
        require("dial.map").dec_normal(),
        { desc = "Dial: Decrement" }
      )
      vim.api.nvim_set_keymap(
        "v",
        "<C-a>",
        require("dial.map").inc_visual(),
        { desc = "Dial: Increment" }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<C-x>",
        require("dial.map").dec_visual(),
        { desc = "Dial: Decrement" }
      )
      vim.api.nvim_set_keymap(
        "v",
        "g<C-a>",
        require("dial.map").inc_gvisual(),
        { desc = "Dial: Increment" }
      )
      vim.api.nvim_set_keymap(
        "n",
        "g<C-x>",
        require("dial.map").dec_gvisual(),
        { desc = "Dial: Decrement" }
      )
    end,
  },
}

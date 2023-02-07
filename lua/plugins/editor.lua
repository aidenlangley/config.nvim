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
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    enabled = true,
    config = true,
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
  "gpanders/editorconfig.nvim",
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
        desc = "(S)pectre: Replace in files ",
      },
    },
  },
  {
    "gbprod/yanky.nvim",
    keys = {
      { "p", "<Plug>(YankyPutAfter)", desc = "Put after" },
      { "P", "<Plug>(YankyPutBefore)", desc = "Put before" },
      { "gp", "<Plug>(YankyGPutAfter)", desc = "GPut after" },
      { "gP", "<Plug>(YankyGPutBefore)", desc = "GPut before" },
      { "<C-p>", "<Plug>(YankyCycleBackward)", desc = "Cycle yank backwards" },
      { "<C-k>", "<Plug>(YankyCycleForward)", desc = "Cycle yank forwards" },
      { "y", "<Plug>(YankyYank)", desc = "(Y)ank" },
    },
    opts = { highlight = { timer = 150 } },
  },
}

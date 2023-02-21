return {
  {
    "https://git.sr.ht/~nedia/auto-format.nvim",
    event = { "InsertLeavePre" },
    config = true,
    dev = true,
  },
  {
    "https://git.sr.ht/~nedia/auto-save.nvim",
    event = { "BufReadPre" },
    opts = {
      events = { "InsertLeave", "BufLeave" },
      silent = false,
      exclude_ft = { "neo-tree" },
    },
    dev = false,
  },
  {
    "mcauley-penney/tidy.nvim",
    event = { "BufWrite" },
    config = true,
  },
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    enabled = true,
    config = true,
  },
  {
    "ggandor/leap.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" } },
      { "S", mode = { "n", "x", "o" } },
    },
    config = function()
      require("leap").set_default_keymaps()
    end,
  },
  {
    "ggandor/flit.nvim",
    keys = {
      { "f", mode = { "n", "x", "o" } },
      { "F", mode = { "n", "x", "o" } },
      { "t", mode = { "n", "x", "o" } },
      { "T", mode = { "n", "x", "o" } },
    },
    opts = { labeled_modes = "nx" },
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
    event = { "BufReadPre" },
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
    dependencies = { "kkharji/sqlite.lua" },
    opts = {
      ring = {
        history_length = 10,
        storage = "sqlite",
      },
      highlight = { timer = 150 },
    },
    config = function(_, opts)
      require("yanky").setup(opts)

      local keys = {
        {
          "p",
          "<Plug>(YankyPutAfter)",
          mode = { "n", "x" },
          desc = "Put after",
        },
        {
          "P",
          "<Plug>(YankyPutBefore)",
          mode = { "n", "x" },
          desc = "Put before",
        },
        {
          "<C-n>",
          "<Plug>(YankyCicleForward)",
          desc = "Cycle yanky forwards",
        },
        {
          "<C-p>",
          "<Plug>(YankyCicleBackward)",
          desc = "Cycle yanky backwards",
        },
        {
          "gp",
          "<Plug>(YankyGPutAfter)",
          mode = { "n", "x" },
          desc = "GPut after",
        },
        {
          "gP",
          "<Plug>(YankyGPutBefore)",
          mode = { "n", "x" },
          desc = "GPut before",
        },
        {
          "y",
          "<Plug>(YankyYank)",
          mode = { "n", "x" },
          desc = "(Y)ank",
        },
        {
          "ty",
          require("utils").cmd("YankyRingHistory"),
          desc = "Yanky history...",
        },
      }

      for _, keymap in ipairs(keys) do
        vim.keymap.set(
          keymap.mode or "n",
          keymap[1],
          keymap[2],
          { desc = keymap.desc, noremap = true }
        )
      end
    end,
  },
}

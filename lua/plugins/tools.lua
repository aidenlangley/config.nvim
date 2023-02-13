return {
  {
    "akinsho/toggleterm.nvim",
    keys = { "<C-\\>" },
    opts = {
      open_mapping = "<C-\\>",
      shade_terminals = false,
      direction = "float",
    },
  },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    keys = {
      {
        "<Leader>op",
        function()
          local peek = require("peek")
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        desc = "Open Markdown Preview",
      },
    },
    opts = { theme = "dark" },
  },
}

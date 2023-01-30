return {
  {
    "akinsho/toggleterm.nvim",
    keys = { "<C-t>" },
    opts = {
      open_mapping = "<C-t>",
      direction = "horizontal",
      size = 12,
      persist_size = true,
      hide_numbers = true,
      start_in_insert = true,
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
        desc = "[Peek] Open Markdown Preview",
      },
    },
    opts = { theme = "dark" },
  },
}

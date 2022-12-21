local M = {
  "danymat/neogen",
  event = "BufReadPost",
}

function M.config()
  local neogen = require("neogen")

  neogen.setup({
    snippet_engine = "luasnip",
  })

  -- Generate documentation based on location in document
  require("which-key").register({
    g = {
      name = "Neo[g]en...",
      c = {
        function()
          neogen.generate({ type = "class" })
        end,
        "Generate [C]lass doc",
      },
      f = {
        function()
          neogen.generate({ type = "func" })
        end,
        "Generate [F]unction doc",
      },
      F = {
        function()
          neogen.generate({ type = "file" })
        end,
        "Generate [F]ile doc",
      },
      g = { neogen.generate, "[G]enerate doc" },
      t = {
        function()
          neogen.generate({ type = "type" })
        end,
        "Generate [T]ype doc",
      },
    },
  }, { prefix = "<Leader>c" })
end

return M

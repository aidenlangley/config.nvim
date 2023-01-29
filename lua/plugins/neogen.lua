local M = {
  "danymat/neogen",
  event = "BufWinEnter",
}

function M.config()
  local neogen = require("neogen")
  neogen.setup({ snippet_engine = "luasnip" })

  vim.keymap.set("n", "<Leader>n", neogen.generate, { desc = "Neogen: [G]enerate doc" })
end

return M

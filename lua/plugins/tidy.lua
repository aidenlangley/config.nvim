local M = {
  "mcauley-penney/tidy.nvim",
  event = "BufWinEnter",
}

function M.config()
  require("tidy").setup()
end

return M

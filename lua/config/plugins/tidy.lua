local M = {
  "mcauley-penney/tidy.nvim",
  event = "BufEnter",
}

function M.config()
  require("tidy").setup()
end

return M

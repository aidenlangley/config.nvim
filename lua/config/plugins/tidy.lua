local M = {
  "mcauley-penney/tidy.nvim",
  event = "BufReadPost",
}

function M.config()
  require("tidy").setup()
end

return M

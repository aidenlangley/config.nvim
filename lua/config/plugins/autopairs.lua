local M = {
  "windwp/nvim-autopairs",
  event = "BufWinEnter",
}

function M.config()
  require("nvim-autopairs").setup()
end

return M

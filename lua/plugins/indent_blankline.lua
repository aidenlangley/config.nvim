local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufWinEnter",
}

function M.config()
  require("indent_blankline").setup()
end

return M

local M = {
  "https://git.sr.ht/~nedia/auto-format.nvim",
  event = "BufWinEnter",
  dev = false,
}

function M.config()
  require("auto-format").setup()
end

return M

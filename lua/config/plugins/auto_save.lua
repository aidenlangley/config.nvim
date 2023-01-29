local M = {
  "https://git.sr.ht/~nedia/auto-save.nvim",
  event = "BufWinEnter",
  dev = false,
}

function M.config()
  require("auto-save").setup({
    events = { "InsertLeave", "BufLeave" },
    silent = false,
    exclude_ft = { "neo-tree" },
  })
end

return M

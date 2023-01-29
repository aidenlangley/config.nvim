local M = {
  "https://git.sr.ht/~nedia/auto-save.nvim",
  event = "VeryLazy",
  dev = false,
}

function M.config()
  require("auto-save").setup({
    events = { "InsertLeave", "BufLeave" },
    exclude_ft = { "neo-tree" },
  })
end

return M

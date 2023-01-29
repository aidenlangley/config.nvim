local M = {
  "petertriho/nvim-scrollbar",
  event = "BufWinEnter",
}

function M.config()
  require("scrollbar").setup({
    excluded_filetypes = { "neo-tree" },
  })
end

return M

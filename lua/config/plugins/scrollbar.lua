local M = {
  "petertriho/nvim-scrollbar",
  event = "BufReadPost",
}

function M.config()
  require("scrollbar").setup({
    excluded_filetypes = { "neo-tree" },
  })
end

return M

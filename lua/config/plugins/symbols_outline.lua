local M = {
  "simrat39/symbols-outline.nvim",
  cmd = "SymbolsOutline",
}

function M.config()
  require("symbols-outline").setup({
    width = 28,
  })
end

return M

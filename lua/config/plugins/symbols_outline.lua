local M = {
  "simrat39/symbols-outline.nvim",
  cmd = "SymbolsOutline",
}

function M.config()
  require("symbols-outline").setup({
    width = 32,
  })
end

return M

local M = {
  "simrat39/symbols-outline.nvim",
  cmd = "SymbolsOutline",
}

function M.init()
  vim.keymap.set(
    "n",
    "<Leader>ls",
    require("utils").cmd("SymbolsOutline"),
    { desc = "Symbols Outline" }
  )
end

function M.config()
  require("symbols-outline").setup({
    width = 32,
  })
end

return M

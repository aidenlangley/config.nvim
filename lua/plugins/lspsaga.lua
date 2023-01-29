local M = {
  "glepnir/lspsaga.nvim",
  event = "BufRead",
}

function M.config()
  require("lspsaga").setup({
    symbol_in_winbar = { enable = false },
  })
end

return M

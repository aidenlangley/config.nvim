local M = {
  "ellisonleao/glow.nvim",
  cmd = { "Glow" },
}

function M.config()
  require("glow").setup({})
end

return M

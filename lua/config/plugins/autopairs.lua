local M = {
  "windwp/nvim-autopairs",
  event = "BufReadPost",
}

function M.config()
  require("nvim-autopairs").setup()
end

return M
